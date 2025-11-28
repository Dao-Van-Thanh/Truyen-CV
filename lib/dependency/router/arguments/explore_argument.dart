import 'package:flutter_template/dependency/network_api/story/filter/story_filter_request.dart';

class ExploreArgument {
  final StoryFilterRequest request;
  final String? title;

  const ExploreArgument({
    required this.request,
    this.title,
  });
}
