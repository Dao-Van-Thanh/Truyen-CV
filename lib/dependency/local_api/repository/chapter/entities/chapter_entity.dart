import 'dart:convert';

import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';

class ChapterEntity {
  final String id;
  final String bookId;
  final String listChapterItemData;
  final String timeStamp;

  const ChapterEntity({
    required this.id,
    required this.bookId,
    required this.listChapterItemData,
    required this.timeStamp,
  });

  factory ChapterEntity.fromMap(Map<String, dynamic> map) {
    return ChapterEntity(
      id: map['id'] as String,
      bookId: map['bookId'] as String,
      listChapterItemData: map['listChapterItemData'] as String,
      timeStamp: map['timeStamp'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookId': bookId,
      'listChapterItemData': listChapterItemData,
      'timeStamp': timeStamp,
    };
  }

  ListChapterRes toChapterModel() {
    return ListChapterRes.fromJson(
      jsonDecode(listChapterItemData) as Map<String, dynamic>,
    );
  }
}
