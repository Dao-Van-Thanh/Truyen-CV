import 'dart:convert';

import 'package:truyen_cv/dependency/local_api/repository/book/entities/list_chapter_entity.dart';
import 'package:truyen_cv/dependency/network_api/novel/list_chapter/list_chapter_res.dart';

class ChapterEntity {
  final String id;
  final String bookId;
  final String listChapterItemData;
  final int orderIndex;
  final String timeStamp;

  const ChapterEntity({
    required this.id,
    required this.bookId,
    required this.listChapterItemData,
    required this.orderIndex,
    required this.timeStamp,
  });

  factory ChapterEntity.fromMap(Map<String, dynamic> map) {
    return ChapterEntity(
      id: map['id'] as String,
      bookId: map['bookId'] as String,
      listChapterItemData: map['listChapterItemData'] as String,
      orderIndex: map['orderIndex'] as int? ?? 0,
      timeStamp: map['timeStamp'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookId': bookId,
      'listChapterItemData': listChapterItemData,
      'orderIndex': orderIndex,
      'timeStamp': timeStamp,
    };
  }

  ListChapterRes toChapterModel() {
    final json = jsonDecode(listChapterItemData) as Map<String, dynamic>;

    if (json.containsKey('ID') || json.containsKey('NAME')) {
      final chapter = ListChapterRes.fromJson(json);
      return chapter.copyWith(order: chapter.order ?? orderIndex.toString());
    }

    final localChapter = ListChapterEntity.fromJson(json);

    return ListChapterRes(
      id: localChapter.id,
      order: orderIndex.toString(),
      name: localChapter.name,
    );
  }
}
