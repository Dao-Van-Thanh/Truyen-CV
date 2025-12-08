import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:sqflite/sqflite.dart';

class BookRepository {
  final Database db;
  static const String _tableName = 'books';

  BookRepository({required this.db});

  Future<void> upsertBook(BookEntity book) async {
    final bookToSave = book.copyWith(
      timeStamp: DateTime.now().toIso8601String(),
    );

    await db.insert(
      _tableName,
      bookToSave.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<BookEntity>> getAllBooks() async {
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      orderBy: 'lastReadTime DESC, timeStamp DESC',
    );

    return maps.map((e) => BookEntity.fromMap(e)).toList();
  }

  Future<List<BookEntity>> getFavoriteBooks() async {
    final maps = await db.query(
      _tableName,
      where: 'isFavorite = ?',
      whereArgs: [1],
      orderBy: 'lastReadTime DESC',
    );

    return maps.map((e) => BookEntity.fromMap(e)).toList();
  }

  Future<bool> isBookFavorite(String bookId) async {
    final maps = await db.query(
      _tableName,
      columns: ['isFavorite'],
      where: 'id = ?',
      whereArgs: [bookId],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      final isFavorite = maps.first['isFavorite'] as int;
      return isFavorite == 1;
    }
    return false;
  }

  Future<BookEntity?> getBookById(String id) async {
    final maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return BookEntity.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updateReadingProgress({
    required String bookId,
    required String currentChapterId,
    required double scrollOffset,
  }) async {
    final now = DateTime.now().toIso8601String();

    await db.rawUpdate('''
      UPDATE $_tableName
      SET currentChapterId = ?, 
          scrollOffset = ?, 
          lastReadTime = ?,
          timeStamp = ?
      WHERE id = ?
    ''', [
      currentChapterId,
      scrollOffset,
      now,
      now,
      bookId,
    ]);
  }

  Future<void> deleteBook(String id) async {
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
