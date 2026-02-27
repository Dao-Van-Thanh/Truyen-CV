import 'package:flutter_template/dependency/network_api/novel/filter/story_filter_request.dart';

sealed class ExploreCategoryArgument {
  final String? title;

  const ExploreCategoryArgument({
    this.title,
  });
}

class ExploreNovelCategoryArgument extends ExploreCategoryArgument {
  final StoryFilterRequest request;

  const ExploreNovelCategoryArgument({
    required this.request,
    super.title,
  });
}

class ExploreComicCategoryArgument extends ExploreCategoryArgument {
  final String categorySlug;

  const ExploreComicCategoryArgument({
    required this.categorySlug,
    super.title,
  });
}
