import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/dependency/router/arguments/list_chapter_argument.dart';
import 'package:flutter_template/dependency/router/arguments/read_story_argument.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/features/story/list_chapter/enum/list_sort_enum.dart';
import 'package:flutter_template/shared/extensions/text_editing_controller_extension.dart';
import 'package:flutter_template/shared/utilities/debounce.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:rxdart/rxdart.dart';

class ListChapterBloc extends BlocBase {
  Ref ref;
  ListChapterArgument args;

  late final networkApiService = ref.read(AppService.networkApi);
  late final routerService = ref.read(AppService.router);
  late final localApiService = ref.read(AppService.localApi);

  final isLoadingSubject = BehaviorSubject<bool>.seeded(false);
  final listChapterSubject = BehaviorSubject<List<ListChapterRes>>.seeded([]);
  List<ListChapterRes> listChapterTemp = [];
  final listSortSubject =
      BehaviorSubject<ListSortEnum>.seeded(ListSortEnum.sortOld);

  final scrollController = ScrollController();
  final searchController = TextEditingController();

  final isSearchingSubject = BehaviorSubject<bool>.seeded(false);
  final isContinueReadingSubject = BehaviorSubject<bool>.seeded(false);

  bool _isLoadingLocal = false;

  ListChapterBloc(this.ref, {required this.args}) {
    if (args.listChapter.isNotEmpty) {
      listChapterSubject.value = args.listChapter;
      listChapterTemp = args.listChapter;
    } else {
      init();
    }
    _getBookLocal();
    _listens();
  }

  @override
  void dispose() {
    super.dispose();
    isLoadingSubject.close();
    listChapterSubject.close();
    listSortSubject.close();
    scrollController.dispose();
    isSearchingSubject.close();
    searchController.dispose();
    isContinueReadingSubject.close();
    _removeListens();
  }

  Future<void> init() async {
    isLoadingSubject.value = true;
    final res = await networkApiService.storyRepository.getListChapter(
      args.storyData?.id ?? '',
    );
    if (isDispose) return;
    isLoadingSubject.value = false;

    res.whenOrNull(
      success: (data) {
        final listChapter = data.data;
        listChapterSubject.value = listChapter ?? [];
        listChapterTemp = listChapter ?? [];
      },
      error: (error) {
        logger.e('ListChapterBloc init error: $error');
      },
    );
  }

  void onSelectedSort(ListSortEnum p1) {
    listSortSubject.value = p1;
  }

  void onTapSearch() {
    searchController.clear();
    if (isSearchingSubject.value) {
      isSearchingSubject.value = false;
    } else {
      isSearchingSubject.value = true;
    }
  }

  void _listens() {
    searchController.addListenerText(
      (text) {
        final query = text.toLowerCase();
        if (query.isEmpty) {
          listChapterSubject.value = listChapterTemp;
        } else {
          final filteredList = listChapterTemp.where((chapter) {
            final titleLower = chapter.name?.toLowerCase() ?? '';
            return titleLower.contains(query);
          }).toList();
          listChapterSubject.value = filteredList;
        }
      },
      debounce: Debounce(milliseconds: 300),
    );
  }

  void _removeListens() {
    searchController.removeListener(_listens);
  }

  void onTapChapter(ListChapterRes chapter) {
    _upsertBookToLocal(
      chapter.id ?? '',
      0.0,
    ).then(
      (_) {
        routerService
            .push(
          RouteInput.readStory(
            args: ReadStoryArgument(
              storyId: args.storyData?.id ?? '',
              selectedChapterId: chapter.id ?? '',
              listChapter: listChapterSubject.value,
              scrollOffset: 0.0,
            ),
          ),
        )
            .then((_) {
          _getBookLocal();
        });
      },
    );
  }

  Future<void> _getBookLocal() async {
    final bookEntityLocal = await localApiService.bookRepository.getBookById(
      args.storyData?.id ?? '',
    );
    if (isDispose) return;
    if (bookEntityLocal != null && bookEntityLocal.currentChapterId != null) {
      isContinueReadingSubject.value = true;
    } else {
      isContinueReadingSubject.value = false;
    }
  }

  Future<void> _upsertBookToLocal(
    String selectedChapterId,
    double scrollOffset,
  ) async {
    if (_isLoadingLocal) return;

    try {
      final listChapter = listChapterSubject.value;
      final bookEntity = BookEntity(
        id: args.storyData?.id ?? '',
        listChapters: listChapter,
        storyData: jsonEncode(args.storyData?.toJson()),
        currentChapterId: selectedChapterId,
        scrollOffset: scrollOffset,
        lastReadTime: DateTime.now().toIso8601String(),
        timeStamp: DateTime.now().toIso8601String(),
        isLocal: false,
      );
      _isLoadingLocal = true;
      await localApiService.bookRepository.upsertBook(
        bookEntity,
        isHasUpdateListChapter: true,
      );
      _isLoadingLocal = false;
    } catch (e) {
      logger.e('Error saving book to local: $e');
    }
  }

  void onTapContinueReading() async {
    final bookEntityLocal = await localApiService.bookRepository.getBookById(
      args.storyData?.id ?? '',
    );
    if (isDispose) return;
    if (bookEntityLocal == null) return;
    routerService.push(
      RouteInput.readStory(
        args: ReadStoryArgument(
          storyId: args.storyData?.id ?? '',
          selectedChapterId: bookEntityLocal.currentChapterId ?? '',
          listChapter: listChapterSubject.value,
          scrollOffset: bookEntityLocal.scrollOffset,
        ),
      ),
    );
  }
}
