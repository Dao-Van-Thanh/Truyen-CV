import 'package:flutter_template/dependency/network_api/story/filter/story_filter_response.dart';

class StoryListItemEntity {
  final String storyId, name, thumbUrl, viewed, process;
  final double rating;

  StoryListItemEntity({
    required this.storyId,
    required this.name,
    required this.thumbUrl,
    required this.viewed,
    required this.process,
    required this.rating,
  });

  static StoryListItemEntity fromStoryModel(StoryModel e) {
    return StoryListItemEntity(
      storyId: e.id ?? '',
      name: e.name ?? '',
      thumbUrl: e.thumb ?? '',
      viewed: e.viewed ?? '',
      process: e.process ?? '',
      rating: e.rating ?? 0,
    );
  }
}
