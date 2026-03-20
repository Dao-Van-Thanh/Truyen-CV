import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truyen_cv/bloc/bloc_base.dart';
import 'package:truyen_cv/dependency/app_service.dart';
import 'package:truyen_cv/dependency/router/arguments/explore_category_argument.dart';
import 'package:truyen_cv/dependency/router/arguments/story_search_argument.dart';
import 'package:truyen_cv/dependency/router/utils/route_input.dart';
import 'package:truyen_cv/shared/helper/repository.dart';

class ExploreCategoryBloc extends BlocBase {
  Ref ref;
  ExploreCategoryArgument args;

  late final routerService = ref.read(AppService.router);

  ExploreCategoryBloc(this.ref, {required this.args});

  void onTapSearch() {
    final isNovel = args is ExploreNovelCategoryArgument;

    late StorySearchArgument argsStorySearch;
    if (isNovel) {
      argsStorySearch = StorySearchArgument(
        fetchSearchStory: (ref, keyword, page) {
          return RepositoryHelper.fetchStoryNovelSearch(
            ref,
            keyword: keyword,
            page: page,
          );
        },
        fetchStoryDetail: (ref, storyId) {
          return RepositoryHelper.fetchStoryNovelDetail(
            ref,
            storyId: storyId,
          );
        },
      );
    } else {
      argsStorySearch = StorySearchArgument(
        fetchSearchStory: (ref, keyword, page) {
          return RepositoryHelper.fetchStoryComicSearch(
            ref,
            keyword: keyword,
            page: page,
          );
        },
        fetchStoryDetail: (ref, storyId) {
          return RepositoryHelper.fetchStoryComicDetail(
            ref,
            storyId: storyId,
          );
        },
      );
    }

    routerService.push(
      RouteInput.storySearch(args: argsStorySearch),
    );
  }
}
