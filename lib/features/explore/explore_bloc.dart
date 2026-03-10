import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/router/arguments/story_search_argument.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/features/explore/enum/explore_navigation_enum.dart';
import 'package:flutter_template/shared/helper/repository.dart';

class ExploreBloc extends BlocBase {
  Ref ref;

  late final routerService = ref.read(AppService.router);
  late final configBloc = ref.read(BlocProvider.config);

  ExploreBloc(this.ref);

  void onTapSearch() {
    final currentType = configBloc.exploreNavigationTabSubject.value;

    late StorySearchArgument args;

    switch (currentType) {
      case ExploreNavigationEnum.novel:
        args = StorySearchArgument(
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
        break;
      case ExploreNavigationEnum.comic:
        args = StorySearchArgument(
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
        break;
    }

    routerService.push(
      RouteInput.storySearch(args: args),
    );
  }

  void onTapExploreType() {
    final current = configBloc.exploreNavigationTabSubject.value;

    showModalBottomSheet<ExploreNavigationEnum>(
      context: routerService.rootContext,
      builder: (context) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: ExploreNavigationEnum.values.map((type) {
                final isSelected = type == current;

                return ListTile(
                  leading: IconTheme(
                    data: IconThemeData(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                    child: type.icon,
                  ),
                  title: Text(
                    type.displayName,
                    style: TextStyle(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : null,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                  onTap: () {
                    Navigator.pop(context, type);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    ).then((value) {
      if (value != null && value != current) {
        configBloc.onChangeExploreNavigationTab(value);
      }
    });
  }
}
