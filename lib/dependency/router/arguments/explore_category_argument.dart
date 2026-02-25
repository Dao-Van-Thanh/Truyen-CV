import 'package:flutter_template/dependency/network_api/novel/filter/story_filter_request.dart';

class ExploreCategoryArgument {
  final StoryFilterRequest request;
  final String? title;

  const ExploreCategoryArgument({
    required this.request,
    this.title,
  });
}
