import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/features/story/detail/entities/story_detail_entity.dart';

class StoryDetailArgument {
  final String storyId;
  final Future<StoryDetailEntity?> Function(Ref ref) fetchStoryDetail;

  StoryDetailArgument({
    required this.storyId,
    required this.fetchStoryDetail,
  });
}
