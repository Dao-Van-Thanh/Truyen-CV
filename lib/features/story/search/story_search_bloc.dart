import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/network_api/story/filter/story_filter_response.dart';
import 'package:flutter_template/shared/extensions/text_editing_controller_extension.dart';
import 'package:flutter_template/shared/utilities/debounce.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:rxdart/rxdart.dart';

class StorySearchBloc extends BlocBase {
  Ref ref;

  late final networkApiService = ref.read(AppService.networkApi);

  final searchController = TextEditingController();

  final storiesSubject = BehaviorSubject<List<StoryModel>>.seeded([]);
  final isLoadingSubject = BehaviorSubject<bool>.seeded(false);
  final isFirstLoadSubject = BehaviorSubject<bool>.seeded(true);
  final hasMoreSubject = BehaviorSubject<bool>.seeded(true);

  final searchFocusNode = FocusNode();

  int _currentPage = 1;

  StorySearchBloc(this.ref) {
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
      final res = await networkApiService.storyRepository.searchStory(
        page: _currentPage,
        keyword: searchController.text,
      );

      if (isDispose) return;

      res.whenOrNull(
        success: (data) {
          final newStories = data.data ?? [];
          if (newStories.length < CommonConstants.pageSize) {
            hasMoreSubject.value = false;
          }
          storiesSubject.value.addAll(newStories);
          _currentPage++;
          isLoadingSubject.value = false;
          isFirstLoadSubject.value = false;
        },
        error: (error) {
          isLoadingSubject.value = false;
          isFirstLoadSubject.value = false;
          logger.e('Search story error: ${error.errorMessage}');
        },
      );
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
}
