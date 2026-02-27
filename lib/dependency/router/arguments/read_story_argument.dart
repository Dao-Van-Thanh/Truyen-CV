import 'package:flutter_template/dependency/local_api/repository/book/entities/list_chapter_entity.dart';

class ReadStoryArgument {
  final String storyId;
  final String selectedChapterId;
  final double scrollOffset;
  final List<ListChapterEntity> listChapter;

  final bool isOfflineImport;

  ReadStoryArgument({
    required this.storyId,
    required this.selectedChapterId,
    required this.listChapter,
    required this.scrollOffset,
    this.isOfflineImport = false,
  });
}
