import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/router/arguments/explore_category_argument.dart';
import 'package:flutter_template/dependency/router/arguments/story_search_argument.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/shared/helper/repository.dart';

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
          final slug = storyId.split('||').lastOrNull ?? '';
          return RepositoryHelper.fetchStoryComicDetail(
            ref,
            storySlug: slug,
          );
        },
      );
    }

    routerService.push(
      RouteInput.storySearch(args: argsStorySearch),
    );
  }
}
