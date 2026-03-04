import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/story_entity.dart';
import 'package:flutter_template/features/story/detail/entities/story_detail_entity.dart';

class StoryDetailArgument {
  final StoryEntity story;
  final Future<StoryDetailEntity?> Function(Ref ref) fetchStoryDetail;

  StoryDetailArgument({
    required this.story,
    required this.fetchStoryDetail,
  });
}
