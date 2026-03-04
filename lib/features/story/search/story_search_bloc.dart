import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/story_entity.dart';
import 'package:flutter_template/dependency/router/arguments/story_detail_argument.dart';
import 'package:flutter_template/dependency/router/arguments/story_search_argument.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/shared/extensions/text_editing_controller_extension.dart';
import 'package:flutter_template/shared/utilities/debounce.dart';
import 'package:rxdart/rxdart.dart';

class StorySearchBloc extends BlocBase {
  Ref ref;
  late StorySearchArgument _args;
  late final networkApiService = ref.read(AppService.networkApi);
  late final routerService = ref.read(AppService.router);

  final searchController = TextEditingController();

  final storiesSubject = BehaviorSubject<List<StoryEntity>>.seeded([]);
  final isLoadingSubject = BehaviorSubject<bool>.seeded(false);
  final isFirstLoadSubject = BehaviorSubject<bool>.seeded(true);
  final hasMoreSubject = BehaviorSubject<bool>.seeded(true);

  final searchFocusNode = FocusNode();

  int _currentPage = 1;

  StorySearchBloc(this.ref, {required StorySearchArgument args}) {
    _args = args;
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    storiesSubject.close();
    isLoadingSubject.close();
    isFirstLoadSubject.close();
    hasMoreSubject.close();
    searchFocusNode.dispose();
  }

  void onTapClearSearch() {
    searchController.clear();
  }

  void _init() {
    loadData();
    _listenSearchInput();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocusNode.requestFocus();
    });
  }

  void _listenSearchInput() {
    searchController.addListenerText(
      (_) {
        storiesSubject.value = [];
        _currentPage = 1;
        hasMoreSubject.value = true;
        isFirstLoadSubject.value = true;
        loadData();
      },
      debounce: Debounce(milliseconds: 300),
    );
  }

  Future<void> loadData() async {
    if (isLoadingSubject.value) return;

    isLoadingSubject.value = true;

    try {
      final newStories = await _args.fetchSearchStory(
        ref,
        searchController.text,
        _currentPage,
      );

      if (isDispose) return;

      if (newStories.length < CommonConstants.pageSize) {
        hasMoreSubject.value = false;
      }
      storiesSubject.value.addAll(newStories);
      _currentPage++;
      isLoadingSubject.value = false;
      isFirstLoadSubject.value = false;
    } catch (e) {
      if (isDispose) return;
      isLoadingSubject.value = false;
      isFirstLoadSubject.value = false;
    }
  }

  Future<void> onRefresh() async {
    storiesSubject.value.clear();
    _currentPage = 1;
    hasMoreSubject.value = true;
    isFirstLoadSubject.value = true;
    await loadData();
  }

  void onTapStory(StoryEntity story) {
    routerService.push(
      RouteInput.storyDetail(
        args: StoryDetailArgument(
          story: story,
          fetchStoryDetail: (ref) {
            return _args.fetchStoryDetail(ref, story.id);
          },
        ),
      ),
    );
  }
}
      