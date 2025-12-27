import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter_template/dependency/network_api/story/filter/story_filter_response.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';

class BookEntity {
  final String id;
  final String storyData;
  final List<ListChapterRes> listChapters;
  final String? currentChapterId;
  final double scrollOffset;
  final bool isFavorite;
  final String? lastReadTime;
  final String timeStamp;

  const BookEntity({
    required this.id,
    required this.storyData,
    this.listChapters = const [],
    this.currentChapterId,
    this.scrollOffset = 0.0,
    this.isFavorite = false,
    this.lastReadTime,
    required this.timeStamp,
  });

  factory BookEntity.fromMap(Map<String, dynamic> map) {
    return BookEntity(
      id: map['id'] as String,
      storyData: map['storyData'] as String,
      currentChapterId: map['currentChapterId'] as String?,
      scrollOffset: (map['scrollOffset'] as num?)?.toDouble() ?? 0.0,
      isFavorite: (map['isFavorite'] as int? ?? 0) == 1,
      lastReadTime: map['lastReadTime'] as String?,
      timeStamp: map['timeStamp'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'storyData': storyData,
      'currentChapterId': currentChapterId,
      'scrollOffset': scrollOffset,
      'isFavorite': isFavorite ? 1 : 0,
      'lastReadTime': lastReadTime,
      'timeStamp': timeStamp,
    };
  }

  ListChapterRes? get lastReadChapter {
    if (listChapters.isEmpty) return null;
    if (currentChapterId == null) return listChapters.first;
    return listChapters.firstWhereOrNull(
      (c) => c.id == currentChapterId,
    );
  }

  String get readProgressPercent {
    final lastChapter = lastReadChapter;
    if (lastChapter == null) return '0';
    final index = listChapters.indexOf(lastChapter);
    if (index == -1) return '0';
    final percent = ((index + 1) / listChapters.length) * 100;
    return '${percent.toStringAsFixed(0)}%';
  }

  String get readProgressFraction {
    final lastChapter = lastReadChapter;
    if (lastChapter == null) return '0/${listChapters.length}';
    final index = listChapters.indexOf(lastChapter);
    if (index == -1) return '0/${listChapters.length}';
    return '${index + 1}/${listChapters.length}';
  }

  StoryModel get storyModel {
    return StoryModel.fromJson(
      jsonDecode(storyData) as Map<String, dynamic>,
    );
  }

  BookEntity copyWith({
    String? id,
    String? storyData,
    List<ListChapterRes>? listChapters,
    String? currentChapterId,
    double? scrollOffset,
    bool? isFavorite,
    String? lastReadTime,
    String? timeStamp,
  }) {
    return BookEntity(
      id: id ?? this.id,
      storyData: storyData ?? this.storyData,
      listChapters: listChapters ?? this.listChapters,
      currentChapterId: currentChapterId ?? this.currentChapterId,
      scrollOffset: scrollOffset ?? this.scrollOffset,
      isFavorite: isFavorite ?? this.isFavorite,
      lastReadTime: lastReadTime ?? this.lastReadTime,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }
}
