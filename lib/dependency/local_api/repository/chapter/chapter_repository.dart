import 'dart:convert';

import 'package:flutter_template/dependency/local_api/repository/chapter/entities/chapter_contents_entity.dart';
import 'package:flutter_template/dependency/local_api/repository/chapter/entities/chapter_entity.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:sqflite/sqflite.dart';

class ChapterRepository {
  final Database db;

  static const String _chaptersTable = 'chapters';
  static const String _chapterContentsTable = 'chapter_contents';

  ChapterRepository({required this.db});

  Future<void> upsertChapter({
    required String bookId,
    required ListChapterRes chapter,
  }) async {
    final entity = ChapterEntity(
      id: chapter.id ?? '',
      bookId: bookId,
      listChapterItemData: jsonEncode(chapter.toJson()),
      timeStamp: DateTime.now().toIso8601String(),
    );

    await db.insert(
      _chaptersTable,
      entity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> upsertChaptersBatch({
    required String bookId,
    required List<ListChapterRes> chapters,
    int batchSize = 300,
    DatabaseExecutor? dbOverride,
  }) async {
    final executor = dbOverride ?? db;

    for (var i = 0; i < chapters.length; i += batchSize) {
      final batch = executor.batch();
      final end =
          (i + batchSize < chapters.length) ? i + batchSize : chapters.length;
      final slice = chapters.sublist(i, end);
      for (final chapter in slice) {
        batch.insert(
          _chaptersTable,
          {
            'id': chapter.id,
            'bookId': bookId,
            'listChapterItemData': jsonEncode(chapter.toJson()),
            'timeStamp': DateTime.now().toIso8601String(),
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);
    }
  }

  Future<List<ListChapterRes>> getChaptersByBookId(
    String bookId, {
    int? limit,
    int? offset,
  }) async {
    final maps = await db.query(
      _chaptersTable,
      where: 'bookId = ?',
      whereArgs: [bookId],
      orderBy: 'id ASC',
      limit: limit,
      offset: offset,
    );

    return maps.map((e) => ChapterEntity.fromMap(e).toChapterModel()).toList();
  }

  Future<ListChapterRes?> getChapterById(String chapterId) async {
    final maps = await db.query(
      _chaptersTable,
      where: 'id = ?',
      whereArgs: [chapterId],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return ChapterEntity.fromMap(maps.first).toChapterModel();
  }

  Future<bool> hasChapters(String bookId) async {
    final result = Sqflite.firstIntValue(
      await db.rawQuery(
        'SELECT COUNT(*) FROM $_chaptersTable WHERE bookId = ?',
        [bookId],
      ),
    );

    return (result ?? 0) > 0;
  }

  Future<void> deleteChaptersByBookId(String bookId) async {
    await db.delete(
      _chaptersTable,
      where: 'bookId = ?',
      whereArgs: [bookId],
    );
  }

  Future<void> upsertChapterContentsBatch({
    required List<ChapterContentsEntity>
        contents, // List [{'chapterId': '...', 'content': '...'}]
    int batchSize = 100, // Batch nhỏ hơn vì text nặng
    DatabaseExecutor? dbOverride,
  }) async {
    final executor = dbOverride ?? db;

    for (var i = 0; i < contents.length; i += batchSize) {
      final batch = executor.batch();
      final end =
          (i + batchSize < contents.length) ? i + batchSize : contents.length;
      final slice = contents.sublist(i, end);

      for (final item in slice) {
        // Tạo ID mới cho row content nếu chưa có, hoặc để DB tự sinh nếu ID là AutoInc
        // Nhưng ở đây ta manual ID để kiểm soát
        final contentId = item.id;

        batch.insert(
          _chapterContentsTable,
          {
            'id': contentId, // ID của row content
            'chapterId': item.chapterId,
            'content': item.content,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    }
  }

  Future<ChapterContentsEntity?> getChapterContent(String chapterId) async {
    final maps = await db.query(
      _chapterContentsTable,
      where: 'chapterId = ?',
      whereArgs: [chapterId],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return ChapterContentsEntity.fromMap(maps.first);
    }
    return null;
  }
}
