import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/story_entity.dart';
import 'package:flutter_template/features/story/detail/entities/story_detail_entity.dart';

class StorySearchArgument {
  final Future<List<StoryEntity>> Function(Ref ref, String keyword, int page)
      fetchSearchStory;

  final Future<StoryDetailEntity?> Function(
    Ref<Object?> ref,
    String storyId,
  ) fetchStoryDetail;

  StorySearchArgument({
    required this.fetchSearchStory,
    required this.fetchStoryDetail,
  });
}
