import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';

class ReadStoryArgument {
  final String selectedChapterId;
  final List<ListChapterRes> listChapter;

  ReadStoryArgument({
    required this.selectedChapterId,
    required this.listChapter,
  });
}
