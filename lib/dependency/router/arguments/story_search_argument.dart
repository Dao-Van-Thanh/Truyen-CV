import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truyen_cv/dependency/local_api/repository/book/entities/story_entity.dart';
import 'package:truyen_cv/features/story/detail/entities/story_detail_entity.dart';

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
