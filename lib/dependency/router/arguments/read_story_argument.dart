import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';

class ReadStoryArgument {
  final String selectedChapterId;
  final double scrollOffset;
  final List<ListChapterRes> listChapter;

  ReadStoryArgument({
    required this.selectedChapterId,
    required this.listChapter,
    this.scrollOffset = 0.0,
  });
}
