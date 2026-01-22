import 'package:flutter_template/shared/utilities/logger.dart';

class ChapterContentsEntity {
  final String id;
  final String chapterId;
  final String content;

  ChapterContentsEntity({
    required this.id,
    required this.chapterId,
    required this.content,
  });

  static ChapterContentsEntity? fromMap(Map<String, dynamic> map) {
    try {
      return ChapterContentsEntity(
        id: map['id'] as String,
        chapterId: map['chapterId'] as String,
        content: map['content'] as String,
      );
    } catch (e) {
      logger.e('Lỗi chuyển ChapterContentsEntity từ Map: $e');
      return null;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chapterId': chapterId,
      'content': content,
    };
  }
}
