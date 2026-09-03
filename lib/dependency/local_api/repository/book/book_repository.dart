import 'dart:convert';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:truyen_cv/constants/constants.dart';
import 'package:truyen_cv/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:truyen_cv/dependency/local_api/repository/book/entities/list_chapter_entity.dart';
import 'package:truyen_cv/dependency/local_api/repository/chapter/chapter_repository.dart';
import 'package:truyen_cv/dependency/local_api/repository/chapter/entities/chapter_contents_entity.dart';
import 'package:truyen_cv/shared/utilities/logger.dart';
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
          jsonEncode(bookToSave.storyData.toJson()),
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

  Future<List<BookEntity>> getFavoriteBooks({
    required int page,
    int limit = CommonConstants.pageSize,
  }) async {
    final books = await db.query(
      _booksTable,
      where: 'isFavorite = ?',
      whereArgs: [1],
      orderBy: 'timeStamp DESC',
      limit: limit,
      offset: page * limit,
    );

    return _attachChaptersToBooks(books);
  }

  Future<List<BookEntity>> getRecentReadBooks({
    required int page,
    int limit = CommonConstants.pageSize,
  }) async {
    final now = DateTime.now();
    final oneMonthAgo = DateTime(now.year, now.month - 1, now.day);

    final books = await db.query(
      _booksTable,
      where: 'lastReadTime >= ?',
      whereArgs: [oneMonthAgo.toIso8601String()],
      orderBy: 'lastReadTime DESC',
      limit: limit,
      offset: page * limit,
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
      final thumbPath = await _getLocalThumbPath(id);

      await db.transaction((txn) async {
        await txn.delete(
          'chapter_contents',
          where: '''
            chapterId IN (
              SELECT id FROM $_chaptersTable WHERE bookId = ?
            )
          ''',
          whereArgs: [id],
        );

        await txn.delete(
          _chaptersTable,
          where: 'bookId = ?',
          whereArgs: [id],
        );

        await txn.delete(
          'routes',
          where: 'bookId = ?',
          whereArgs: [id],
        );

        await txn.delete(
          _booksTable,
          where: 'id = ?',
          whereArgs: [id],
        );
      });

      if (thumbPath != null) {
        await _deleteLocalThumb(thumbPath);
      }

      return true;
    } catch (e) {
      logger.e('Lỗi xóa book: $e');
      return false;
    }
  }

  Future<String?> _getLocalThumbPath(String id) async {
    final bookList = await db.query(
      _booksTable,
      columns: ['storyData'],
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (bookList.isEmpty) return null;

    try {
      final storyDataStr = bookList.first['storyData'] as String;
      final storyMap = jsonDecode(storyDataStr);
      final thumbPath = storyMap['thumb'] as String?;

      if (thumbPath == null ||
          thumbPath.isEmpty ||
          thumbPath.startsWith('http')) {
        return null;
      }

      return thumbPath;
    } catch (e) {
      logger.w('⚠️ Lỗi khi đọc path ảnh bìa: $e');
      return null;
    }
  }

  Future<void> _deleteLocalThumb(String thumbPath) async {
    try {
      final file = File(thumbPath);
      if (await file.exists()) {
        await file.delete();
        logger.i('🗑️ Đã xóa file ảnh bìa: $thumbPath');
      }
    } catch (e) {
      logger.w('⚠️ Lỗi khi xóa file ảnh bìa: $e');
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
      orderBy: 'bookId ASC, orderIndex ASC, timeStamp ASC',
    );

    final chapterGroup = <String, List<ListChapterEntity>>{};

    for (final map in chapterMaps) {
      final bookId = map['bookId'] as String;

      final listChapterItemDataStr = map['listChapterItemData'] as String?;

      if (listChapterItemDataStr == null) {
        logger.w(
          '⚠️ Bản ghi chapter thiếu trường listChapterItemData, id: ${map['id']}',
        );
        continue;
      }

      final json = jsonDecode(map['listChapterItemData'] as String);

      chapterGroup.putIfAbsent(bookId, () => []);
      chapterGroup[bookId]!.add(ListChapterEntity.fromJson(json));
    }

    return bookMaps.map((bookMap) {
      final bookId = bookMap['id'] as String;
      return BookEntity.fromMap(bookMap).copyWith(
        listChapters: chapterGroup[bookId] ?? [],
      );
    }).toList();
  }

  Future<List<ListChapterEntity>> _getChaptersByBookId(String bookId) async {
    final maps = await db.query(
      _chaptersTable,
      where: 'bookId = ?',
      whereArgs: [bookId],
      orderBy: 'orderIndex ASC, timeStamp ASC',
    );

    return maps.map((e) {
      final json = jsonDecode(e['listChapterItemData'] as String);
      return ListChapterEntity.fromJson(json);
    }).toList();
  }

  Future<void> saveImportedBook({
    required BookEntity book,
    required List<ChapterContentsEntity> chapterContents,
  }) async {
    if (chapterContents.length != book.listChapters.length) {
      throw ArgumentError(
        'chapterContents length must match listChapters length',
      );
    }

    // Đảm bảo timestamp luôn mới
    final now = DateTime.now().toIso8601String();
    final bookToSave = book.copyWith(
      storyData: book.storyData.copyWith(listChapter: const []),
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
          jsonEncode(bookToSave.storyData.toJson()),
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
            chapterId: chapterId,
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

  Future<void> createImportedBook(BookEntity book) async {
    final now = DateTime.now().toIso8601String();
    final bookToSave = book.copyWith(
      storyData: book.storyData.copyWith(listChapter: const []),
      timeStamp: now,
      lastReadTime: now,
      isFavorite: true,
      isLocal: true,
    );

    await db.insert(
      _booksTable,
      bookToSave.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> appendImportedChapters({
    required String bookId,
    required List<ListChapterEntity> chapters,
    required List<ChapterContentsEntity> chapterContents,
    required int startOrderIndex,
  }) async {
    if (chapterContents.length != chapters.length) {
      throw ArgumentError(
        'chapterContents length must match chapters length',
      );
    }

    await db.transaction((txn) async {
      await chapterRepository.upsertChaptersBatch(
        bookId: bookId,
        chapters: chapters,
        startOrderIndex: startOrderIndex,
        dbOverride: txn,
      );

      final contents = List.generate(chapterContents.length, (index) {
        return ChapterContentsEntity(
          id: chapterContents[index].id,
          chapterId: chapters[index].id,
          content: chapterContents[index].content,
        );
      });

      await chapterRepository.upsertChapterContentsBatch(
        contents: contents,
        dbOverride: txn,
      );
    });
  }

  Future<void> updateImportedBookTotalChapter({
    required String bookId,
    required int totalChapter,
  }) async {
    final books = await db.query(
      _booksTable,
      where: 'id = ?',
      whereArgs: [bookId],
      limit: 1,
    );

    if (books.isEmpty) return;

    final book = BookEntity.fromMap(books.first);
    final bookToSave = book.copyWith(
      storyData: book.storyData.copyWith(
        totalChapter: totalChapter.toString(),
        listChapter: const [],
      ),
      timeStamp: DateTime.now().toIso8601String(),
    );

    await db.update(
      _booksTable,
      bookToSave.toMap(),
      where: 'id = ?',
      whereArgs: [bookId],
    );
  }
}
