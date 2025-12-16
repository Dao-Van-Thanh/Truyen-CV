import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:flutter_template/dependency/network_api/story/detail/story_detail_response.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/dependency/router/arguments/list_chapter_argument.dart';
import 'package:flutter_template/dependency/router/arguments/read_story_argument.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:rxdart/rxdart.dart';

class StoryDetailBloc extends BlocBase {
  Ref ref;
  String storyId;

  late final networkApiService = ref.read(AppService.networkApi);
  late final routerService = ref.read(AppService.router);
  late final localApiService = ref.read(AppService.localApi);

  final isLoadingSubject = BehaviorSubject<bool>.seeded(false);
  final isLoadingListChapterSubject = BehaviorSubject<bool>.seeded(false);

  final storyDetailSubject = BehaviorSubject<StoryDetailResponse?>.seeded(null);
  final listChapterSubject = BehaviorSubject<List<ListChapterRes>>.seeded([]);
  final isContinueReadingSubject = BehaviorSubject<bool>.seeded(false);
  final isFavoriteSubject = BehaviorSubject<bool>.seeded(false);

  final scrollController = ScrollController();

  Completer<void>? _loadListChapterCompleter;

  bool _isLoadingLocal = false;

  final scrollBehaviorSubject =
      BehaviorSubject<double>.seeded(0.0); // 0.0 - 1.0

  StoryDetailBloc(this.ref, {required this.storyId}) {
    _getBookLocal();
    loadStoryDetail();
    loadListChapter();
    _listeners();
  }

  @override
  void dispose() {
    super.dispose();
    isLoadingSubject.close();
    storyDetailSubject.close();
    scrollController.dispose();
    scrollBehaviorSubject.close();
    listChapterSubject.close();
    isLoadingListChapterSubject.close();
    isContinueReadingSubject.close();
    isFavoriteSubject.close();
    _removeListeners();
  }

  void _listeners() {
    scrollController.addListener(() {
      final maxScroll = 100;
      final currentScroll = scrollController.position.pixels;
      final scrollPercent = (currentScroll / maxScroll).clamp(0.0, 1.0);
      scrollBehaviorSubject.add(scrollPercent);
    });
  }

  void _removeListeners() {
    scrollController.removeListener(() {});
  }

  Future<void> loadStoryDetail() async {
    if (isLoadingSubject.value) return;
    isLoadingSubject.value = true;
    final res = await networkApiService.storyRepository.storyDetail(storyId);
    if (isDispose) return;
    isLoadingSubject.value = false;

    res.whenOrNull(
      success: (data) {
        storyDetailSubject.value = data.data;
      },
      error: (error) {
        logger
            .e('StoryDetailBloc _loadStoryDetail error: ${error.errorMessage}');
      },
    );
  }

  Future<void> loadListChapter() async {
    if (isLoadingListChapterSubject.value) return;
    isLoadingListChapterSubject.value = true;
    _loadListChapterCompleter = Completer<void>();
    final res = await networkApiService.storyRepository.getListChapter(
      storyId,
    );
    if (isDispose) return;
    isLoadingListChapterSubject.value = false;
    _loadListChapterCompleter?.complete();

    res.whenOrNull(
      success: (data) {
        final listChapter = data.data;
        listChapterSubject.value = listChapter ?? [];
      },
      error: (error) {
        logger
            .e('StoryDetailBloc loadListChapter error: ${error.errorMessage}');
      },
    );
  }

  void onTapCopyStoryName() {
    final storyName = storyDetailSubject.value?.name ?? '';
    final context = routerService.rootContext;
    Clipboard.setData(ClipboardData(text: storyName));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.storyDetail.copyStoryNameSuccess(name: storyName)),
      ),
    );
  }

  void onTapNextListChapter() {
    final args = ListChapterArgument(
      storyData: storyDetailSubject.value,
      storyName: storyDetailSubject.value?.name ?? '',
      listChapter: listChapterSubject.value,
    );
    routerService.push(RouteInput.listChapter(args: args));
  }

  void onTapReadNow() {
    if (_loadListChapterCompleter == null) {
      onTapReadNow();
      return;
    }
    _loadListChapterCompleter!.future.then(
      (value) {
        _handleReadChapter();
      },
    );
  }

  Future<void> _handleReadChapter() async {
    if (_isLoadingLocal) {
      logger.i('Already saving to local, please wait.');
      return;
    }

    final bookEntityLocal =
        await localApiService.bookRepository.getBookById(storyId);

    String selectedChapterId = '';

    if (bookEntityLocal != null) {
      selectedChapterId = bookEntityLocal.currentChapterId ?? '';
    }

    if (selectedChapterId.isEmpty) {
      final firstChapter = listChapterSubject.value.isNotEmpty
          ? listChapterSubject.value.first
          : null;
      if (firstChapter != null) {
        selectedChapterId = firstChapter.id ?? '';
      }
    }
    if (selectedChapterId.isEmpty) {
      logger.e('No chapter available to read for storyId: $storyId');
      return;
    }

    final scrollOffset = bookEntityLocal?.scrollOffset ?? 0.0;

    await _upsertBookToLocal(
      selectedChapterId: selectedChapterId,
      scrollOffset: scrollOffset,
      isFavorite: bookEntityLocal?.isFavorite ?? false,
    );

    routerService
        .push(
      RouteInput.readStory(
        args: ReadStoryArgument(
          storyId: storyId,
          selectedChapterId: selectedChapterId,
          listChapter: listChapterSubject.value,
          scrollOffset: scrollOffset,
        ),
      ),
    )
        .then((_) {
      _getBookLocal();
    });
  }

  Future<void> _getBookLocal() async {
    if (_isLoadingLocal) return;
    _isLoadingLocal = true;
    final res = await localApiService.bookRepository.getBookById(storyId);
    _isLoadingLocal = false;
    if (isDispose) return;
    if (res != null) {
      isContinueReadingSubject.value = true;
    } else {
      isContinueReadingSubject.value = false;
    }

    isFavoriteSubject.value = res?.isFavorite ?? false;
  }

  Future<void> _upsertBookToLocal({
    required String? selectedChapterId,
    required double? scrollOffset,
    required bool isFavorite,
  }) async {
    if (_isLoadingLocal) return;

    try {
      final listChapter = listChapterSubject.value;
      final bookEntity = BookEntity(
        id: storyId,
        listChapters: listChapter,
        storyData: jsonEncode(storyDetailSubject.value?.toJson()),
        currentChapterId: selectedChapterId,
        scrollOffset: scrollOffset ?? 0.0,
        isFavorite: isFavorite,
        lastReadTime: DateTime.now().toIso8601String(),
        timeStamp: DateTime.now().toIso8601String(),
      );
      _isLoadingLocal = true;
      await localApiService.bookRepository.upsertBook(bookEntity);
      _isLoadingLocal = false;
    } catch (e) {
      logger.e('Error saving book to local: $e');
    }
  }

  void onTapFavoriteStory() async {
    final currentStatus = isFavoriteSubject.value;
    final newStatus = !currentStatus;

    final bookEntityLocal =
        await localApiService.bookRepository.getBookById(storyId);

    _upsertBookToLocal(
      selectedChapterId: bookEntityLocal?.currentChapterId,
      scrollOffset: bookEntityLocal?.scrollOffset,
      isFavorite: newStatus,
    ).then((_) {
      if (isDispose) return;
      isFavoriteSubject.value = newStatus;
    });
  }
}
