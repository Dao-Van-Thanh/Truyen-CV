import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:truyen_cv/dependency/local_api/repository/chapter/entities/chapter_entity.dart';

void main() {
  group('ChapterEntity.toChapterModel', () {
    test('reads local lowercase chapter json', () {
      final entity = ChapterEntity(
        id: 'chapter-1',
        bookId: 'book-1',
        listChapterItemData: jsonEncode({
          'id': 'chapter-1',
          'name': 'Chương 1',
        }),
        orderIndex: 7,
        timeStamp: '2026-09-03T00:00:00.000',
      );

      final model = entity.toChapterModel();

      expect(model.id, 'chapter-1');
      expect(model.name, 'Chương 1');
      expect(model.order, '7');
    });

    test('reads network uppercase chapter json', () {
      final entity = ChapterEntity(
        id: 'chapter-2',
        bookId: 'book-1',
        listChapterItemData: jsonEncode({
          'ID': 'chapter-2',
          'NAME': 'Chương 2',
        }),
        orderIndex: 8,
        timeStamp: '2026-09-03T00:00:00.000',
      );

      final model = entity.toChapterModel();

      expect(model.id, 'chapter-2');
      expect(model.name, 'Chương 2');
      expect(model.order, '8');
    });
  });
}
