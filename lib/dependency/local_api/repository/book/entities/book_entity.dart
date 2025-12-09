import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter_template/dependency/network_api/story/filter/story_filter_response.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/shared/utilities/string.dart';

class BookEntity {
  final String id;
  final String storyData; // JSON String
  final String listChapterData; // JSON String
  final String? currentChapterId;
  final double scrollOffset;
  final bool isFavorite; // SQLite lưu int (0/1), Dart dùng bool
  final String? lastReadTime;
  final String timeStamp;

  const BookEntity({
    required this.id,
    required this.storyData,
    required this.listChapterData,
    this.currentChapterId,
    this.scrollOffset = 0.0,
    this.isFavorite = false,
    this.lastReadTime,
    required this.timeStamp,
  });

  List<ListChapterRes> get listChapters {
    return StringUtilities.convertStringToListMap(listChapterData)
        .map((e) => ListChapterRes.fromJson(e))
        .toList();
  }

  ListChapterRes? get lastReadChapter {
    if (listChapters.isEmpty) return null;
    if (currentChapterId == null) return listChapters[0];
    return listChapters.firstWhereOrNull(
      (chapter) => chapter.id == currentChapterId,
    );
  }

  StoryModel get storyModel {
    return StoryModel.fromJson(
      jsonDecode(storyData) as Map<String, dynamic>,
    );
  }

  factory BookEntity.fromMap(Map<String, dynamic> map) {
    return BookEntity(
      id: map['id'] as String,
      storyData: map['storyData'] as String,
      listChapterData: map['listChapterData'] as String,
      currentChapterId: map['currentChapterId'] as String?,
      // SQLite trả về num (int hoặc double), cần cast cẩn thận
      scrollOffset: (map['scrollOffset'] as num?)?.toDouble() ?? 0.0,
      // SQLite lưu 1 là true, 0 là false
      isFavorite: (map['isFavorite'] as int?) == 1,
      lastReadTime: map['lastReadTime'] as String?,
      timeStamp:
          map['timeStamp'] as String? ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'storyData': storyData,
      'listChapterData': listChapterData,
      'currentChapterId': currentChapterId,
      'scrollOffset': scrollOffset,
      'isFavorite': isFavorite ? 1 : 0, // Convert bool -> int
      'lastReadTime': lastReadTime,
      'timeStamp': timeStamp,
    };
  }

  BookEntity copyWith({
    String? id,
    String? storyData,
    String? listChapterData,
    String? currentChapterId,
    double? scrollOffset,
    bool? isFavorite,
    String? lastReadTime,
    String? timeStamp,
  }) {
    return BookEntity(
      id: id ?? this.id,
      storyData: storyData ?? this.storyData,
      listChapterData: listChapterData ?? this.listChapterData,
      currentChapterId: currentChapterId ?? this.currentChapterId,
      scrollOffset: scrollOffset ?? this.scrollOffset,
      isFavorite: isFavorite ?? this.isFavorite,
      lastReadTime: lastReadTime ?? this.lastReadTime,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }
}
