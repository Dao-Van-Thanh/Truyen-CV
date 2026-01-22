import 'dart:convert';
import 'dart:io';

import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:flutter_template/dependency/local_api/repository/chapter/chapter_repository.dart';
import 'package:flutter_template/dependency/local_api/repository/chapter/entities/chapter_contents_entity.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class BookRepository {
  final Database db;
  final ChapterRepository chapterRepository;

  static const String _booksTable = 'books';
  static const String _chaptersTable = 'chapters';

  BookRepository({required this.db, required this.chapterRepository});

  Future<void> upsertBook(
    BookEntity book, {
    required bool isHasUpdateListChapter,
  }) async {
    final bookToSave = book.copyWith(
      timeStamp: DateTime.now().toIso8601String(),
    );

    await db.transaction((txn) async {
      // ✅ INSERT hoặc UPDATE trong 1 câu lệnh
      await txn.rawInsert(
        '''
      INSERT INTO $_booksTable (
        id, storyData, currentChapterId, scrollOffset, isFavorite, isLocal, lastReadTime, timeStamp
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
      ON CONFLICT(id) DO UPDATE SET
        storyData = excluded.storyData,
        currentChapterId = excluded.currentChapterId,
        scrollOffset = excluded.scrollOffset,
        isFavorite = excluded.isFavorite,
        isLocal = excluded.isLocal,
        lastReadTime = excluded.lastReadTime,
        timeStamp = excluded.timeStamp
      ''',
        [
          bookToSave.id,
          bookToSave.storyData,
          bookToSave.currentChapterId,
          bookToSave.scrollOffset,
          bookToSave.isFavorite ? 1 : 0,
          bookToSave.isLocal ? 1 : 0,
          bookToSave.lastReadTime,
          bookToSave.timeStamp,
        ],
      );

      if (book.listChapters.isNotEmpty && isHasUpdateListChapter) {
        await chapterRepository.upsertChaptersBatch(
          bookId: book.id,
          chapters: book.listChapters,
          dbOverride: txn,
        );
      }
    });
  }

  Future<List<BookEntity>> getAllBooks() async {
    final books = await db.query(
      _booksTable,
      orderBy: 'lastReadTime DESC, timeStamp DESC',
    );

    return _attachChaptersToBooks(books);
  }

  Future<List<BookEntity>> getFavoriteBooks() async {
    final books = await db.query(
      _booksTable,
      where: 'isFavorite = ?',
      whereArgs: [1],
      orderBy: 'timeStamp DESC',
    );

    return _attachChaptersToBooks(books);
  }

  Future<List<BookEntity>> getRecentReadBooks({DateTime? fromDate}) async {
    final now = fromDate ?? DateTime.now();
    final oneMonthAgo = DateTime(now.year, now.month - 1, now.day);

    final books = await db.query(
      _booksTable,
      where: 'lastReadTime >= ?',
      whereArgs: [oneMonthAgo.toIso8601String()],
      orderBy: 'lastReadTime DESC',
    );

    return _attachChaptersToBooks(books);
  }

  Future<BookEntity?> getBookById(String id) async {
    final books = await db.query(
      _booksTable,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (books.isEmpty) return null;

    final chapters = await _getChaptersByBookId(id);

    return BookEntity.fromMap(books.first).copyWith(
      listChapters: chapters,
    );
  }

  Future<bool> isBookFavorite(String bookId) async {
    final maps = await db.query(
      _booksTable,
      columns: ['isFavorite'],
      where: 'id = ?',
      whereArgs: [bookId],
      limit: 1,
    );

    return maps.isNotEmpty && (maps.first['isFavorite'] as int) == 1;
  }

  Future<bool> deleteBook(String id) async {
    try {
      final bookList = await db.query(
        _booksTable,
        columns: ['storyData'],
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (bookList.isNotEmpty) {
        try {
          final storyDataStr = bookList.first['storyData'] as String;
          final storyMap = jsonDecode(storyDataStr);
          final String? thumbPath = storyMap['thumb'];

          if (thumbPath != null &&
              thumbPath.isNotEmpty &&
              !thumbPath.startsWith('http')) {
            final file = File(thumbPath);
            if (await file.exists()) {
              await file.delete();
              logger.i('🗑️ Đã xóa file ảnh bìa: $thumbPath');
            }
          }
        } catch (e) {
          logger.w('⚠️ Lỗi khi xóa file ảnh bìa: $e');
        }
      }

      await db.delete(
        _booksTable,
        where: 'id = ?',
        whereArgs: [id],
      );

      return true;
    } catch (e) {
      logger.e('Lỗi xóa book: $e');
      return false;
    }
  }

  Future<List<BookEntity>> _attachChaptersToBooks(
    List<Map<String, dynamic>> bookMaps,
  ) async {
    if (bookMaps.isEmpty) return [];

    final bookIds = bookMaps.map((e) => e['id'] as String).toList();

    final chapterMaps = await db.query(
      _chaptersTable,
      where: 'bookId IN (${List.filled(bookIds.length, '?').join(',')})',
      whereArgs: bookIds,
      orderBy: 'timeStamp ASC',
    );

    final chapterGroup = <String, List<ListChapterRes>>{};

    for (final map in chapterMaps) {
      final bookId = map['bookId'] as String;
      final json = jsonDecode(map['listChapterItemData'] as String);

      chapterGroup.putIfAbsent(bookId, () => []);
      chapterGroup[bookId]!.add(ListChapterRes.fromJson(json));
    }

    return bookMaps.map((bookMap) {
      final bookId = bookMap['id'] as String;
      return BookEntity.fromMap(bookMap).copyWith(
        listChapters: chapterGroup[bookId] ?? [],
      );
    }).toList();
  }

  Future<List<ListChapterRes>> _getChaptersByBookId(String bookId) async {
    final maps = await db.query(
      _chaptersTable,
      where: 'bookId = ?',
      whereArgs: [bookId],
      orderBy: 'timeStamp ASC',
    );

    return maps.map((e) {
      final json = jsonDecode(e['listChapterItemData'] as String);
      return ListChapterRes.fromJson(json);
    }).toList();
  }

  Future<void> saveImportedBook({
    required BookEntity book,
    required List<ChapterContentsEntity> chapterContents,
  }) async {
    // Đảm bảo timestamp luôn mới
    final now = DateTime.now().toIso8601String();
    final bookToSave = book.copyWith(
      timeStamp: now,
      lastReadTime: now,
      isFavorite: true,
    );

    await db.transaction((txn) async {
      // A. Lưu Book (Dùng lại logic insert cũ nhưng viết lại cho transaction này)
      await txn.rawInsert(
        '''
        INSERT OR REPLACE INTO $_booksTable (
          id, storyData, currentChapterId, scrollOffset, isFavorite, isLocal, lastReadTime, timeStamp
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ''',
        [
          bookToSave.id,
          bookToSave.storyData,
          bookToSave.currentChapterId,
          bookToSave.scrollOffset,
          1, // isFavorite = true (Hardcode số 1)
          1, // isLocal = true (Đánh dấu truyện offline)
          bookToSave.lastReadTime,
          bookToSave.timeStamp,
        ],
      );
      if (bookToSave.listChapters.isNotEmpty) {
        await chapterRepository.upsertChaptersBatch(
          bookId: bookToSave.id,
          chapters: bookToSave.listChapters,
          dbOverride: txn, // QUAN TRỌNG: Truyền txn vào để chung transaction
        );
      }

      if (chapterContents.isNotEmpty) {
        final contents = List.generate(chapterContents.length, (index) {
          final chapterId = bookToSave.listChapters[index].id;

          return ChapterContentsEntity(
            id: const Uuid().v4(), // ID của dòng content
            chapterId: chapterId ?? '-1',
            content: chapterContents[index].content,
          );
        });

        await chapterRepository.upsertChapterContentsBatch(
          contents: contents,
          dbOverride: txn, // QUAN TRỌNG: Truyền txn vào để chung transaction
        );
      }
    });
  }
}
