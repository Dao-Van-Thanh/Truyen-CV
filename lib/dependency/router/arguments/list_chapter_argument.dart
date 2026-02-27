import 'package:flutter_template/dependency/local_api/repository/book/entities/list_chapter_entity.dart';
import 'package:flutter_template/dependency/network_api/novel/detail/story_detail_response.dart';

class ListChapterArgument {
  final StoryDetailResponse? storyData;
  final String storyName;
  final List<ListChapterEntity> listChapter;

  ListChapterArgument({
    required this.storyData,
    required this.storyName,
    required this.listChapter,
  });
}
