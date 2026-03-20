import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:truyen_cv/bloc/bloc_base.dart';
import 'package:truyen_cv/dependency/app_service.dart';
import 'package:truyen_cv/dependency/local_api/repository/book/entities/story_entity.dart';
import 'package:truyen_cv/dependency/router/arguments/story_detail_argument.dart';
import 'package:truyen_cv/dependency/router/arguments/story_search_argument.dart';
import 'package:truyen_cv/dependency/router/utils/route_input.dart';
import 'package:truyen_cv/shared/extensions/infinite_scroll_paination.dart';
import 'package:truyen_cv/shared/extensions/text_editing_controller_extension.dart';
import 'package:truyen_cv/shared/utilities/debounce.dart';

class StorySearchBloc extends BlocBase {
  Ref ref;
  late StorySearchArgument _args;
  late final networkApiService = ref.read(AppService.networkApi);
  late final routerService = ref.read(AppService.router);

  final searchController = TextEditingController();

  final searchFocusNode = FocusNode();

  late final pagingController = PagingController<int, StoryEntity>(
    getNextPageKey: (state) => state.isLastPage() ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => _loadData(pageKey),
  );

  StorySearchBloc(this.ref, {required StorySearchArgument args}) {
    _args = args;
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    searchFocusNode.dispose();
    pagingController.dispose();
  }

  void onTapClearSearch() {
    searchController.clear();
  }

  void _init() {
    _listenSearchInput();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocusNode.requestFocus();
    });
  }

  void _listenSearchInput() {
    searchController.addListenerText(
      (_) {
        pagingController.refresh();
      },
      debounce: Debounce(milliseconds: 300),
    );
  }

  Future<List<StoryEntity>> _loadData(int page) async {
    try {
      final newStories = await _args.fetchSearchStory(
        ref,
        searchController.text,
        page,
      );

      if (isDispose) return [];

      return newStories;
    } catch (e) {
      if (isDispose) return [];
      return [];
    }
  }

  void onTapStory(StoryEntity story) {
    routerService.push(
      RouteInput.storyDetail(
        args: StoryDetailArgument(
          storyId: story.id,
          fetchStoryDetail: (ref) {
            return _args.fetchStoryDetail(ref, story.id);
          },
        ),
      ),
    );
  }
}
