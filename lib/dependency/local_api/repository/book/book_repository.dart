import 'dart:convert';

import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:flutter_template/dependency/local_api/repository/chapter/chapter_repository.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:sqflite/sqflite.dart';

class BookRepository {
  final Database db;
  final ChapterRepository chapterRepository;

  static const String _booksTable = 'books';
  static const String _chaptersTable = 'chapters';

  BookRepository({required this.db, required this.chapterRepository});

  Future<void> upsertBook(BookEntity book) async {
    final bookToSave = book.copyWith(
      timeStamp: DateTime.now().toIso8601String(),
    );

    await db.transaction((txn) async {
      await txn.insert(
        _booksTable,
        bookToSave.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      if (book.listChapters.isNotEmpty) {
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

  Future<void> deleteBook(String id) async {
    await db.delete(
      _booksTable,
      where: 'id = ?',
      whereArgs: [id],
    );
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
}
