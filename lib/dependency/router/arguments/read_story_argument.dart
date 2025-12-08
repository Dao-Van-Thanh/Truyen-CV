import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';

class ReadStoryArgument {
  final String storyId;
  final String selectedChapterId;
  final double scrollOffset;
  final List<ListChapterRes> listChapter;

  ReadStoryArgument({
    required this.storyId,
    required this.selectedChapterId,
    required this.listChapter,
    required this.scrollOffset,
  });
}
