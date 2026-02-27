import 'package:flutter_template/features/story/detail/entities/story_detail_entity.dart';

class ListChapterArgument {
  final StoryDetailEntity? storyData;
  final String storyName;

  ListChapterArgument({
    required this.storyData,
    required this.storyName,
  });
}
