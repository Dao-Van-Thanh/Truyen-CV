import 'package:flutter_template/dependency/network_api/story/detail/story_detail_response.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';

class ListChapterArgument {
  final StoryDetailResponse? storyData;
  final String storyName;
  final List<ListChapterRes> listChapter;

  ListChapterArgument({
    required this.storyData,
    required this.storyName,
    required this.listChapter,
  });
}
