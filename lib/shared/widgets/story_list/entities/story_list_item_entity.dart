import 'package:flutter_template/dependency/network_api/novel/filter/story_filter_response.dart';

class StoryListItemEntity {
  final String storyId, name, thumbUrl, process;
  final String? viewed;
  final double? rating;

  StoryListItemEntity({
    required this.storyId,
    required this.name,
    required this.thumbUrl,
    this.viewed,
    required this.process,
    this.rating,
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
