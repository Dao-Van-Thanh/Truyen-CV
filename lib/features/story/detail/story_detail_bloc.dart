import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:truyen_cv/bloc/bloc_base.dart';
import 'package:truyen_cv/dependency/app_service.dart';
import 'package:truyen_cv/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:truyen_cv/dependency/local_api/repository/book/entities/list_chapter_entity.dart';
import 'package:truyen_cv/dependency/local_api/repository/book/enum/story_type.dart';
import 'package:truyen_cv/dependency/router/arguments/list_chapter_argument.dart';
import 'package:truyen_cv/dependency/router/arguments/read_comic_argument.dart';
import 'package:truyen_cv/dependency/router/arguments/read_story_argument.dart';
import 'package:truyen_cv/dependency/router/arguments/story_detail_argument.dart';
import 'package:truyen_cv/dependency/router/utils/route_input.dart';
import 'package:truyen_cv/features/story/detail/entities/story_detail_entity.dart';
import 'package:truyen_cv/features/story/read_comic/entities/comic_chapter_entity.dart';
import 'package:truyen_cv/i18n/strings.g.dart';
import 'package:truyen_cv/shared/utilities/logger.dart';

class StoryDetailBloc extends BlocBase {
  Ref ref;

  late StoryDetailArgument _args;

  String get storyId => _args.storyId;

  late final routerService = ref.read(AppService.router);
  late final localApiService = ref.read(AppService.localApi);

  final isLoadingSubject = BehaviorSubject<bool>.seeded(false);

  final storyDetailSubject = BehaviorSubject<StoryDetailEntity?>.seeded(null);
  final isContinueReadingSubject = BehaviorSubject<bool>.seeded(false);
  final isFavoriteSubject = BehaviorSubject<bool>.seeded(false);

  final scrollController = ScrollController();

  bool _isLoadingLocal = false;

  final scrollBehaviorSubject =
      BehaviorSubject<double>.seeded(0.0); // 0.0 - 1.0

  StoryDetailBloc(
    this.ref, {
    required StoryDetailArgument args,
  }) {
    _args = args;
    onRefresh();
    _listeners();
  }

  void onRefresh() {
    loadStoryDetail();
    _getBookLocal();
  }

  @override
  void dispose() {
    super.dispose();
    isLoadingSubject.close();
    storyDetailSubject.close();
    scrollController.dispose();
    scrollBehaviorSubject.close();
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
    final res = await _args.fetchStoryDetail(ref);
    if (isDispose) return;
    isLoadingSubject.value = false;

    storyDetailSubject.value = res;
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
      storyData: storyDetailSubject.value!,
      storyName: storyDetailSubject.value?.name ?? '',
    );
    routerService.push(RouteInput.listChapter(args: args)).then((_) {
      _getBookLocal();
    });
  }

  void onTapReadNow() {
    _handleReadChapter();
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
      final listChapter = storyDetailSubject.value?.listChapter ?? [];
      final firstChapter = listChapter.isNotEmpty ? listChapter.first : null;
      if (firstChapter != null) {
        selectedChapterId = firstChapter.id;
      }
    }
    if (selectedChapterId.isEmpty) {
      logger.e('No chapter available to read for storyId: ${storyId}');
      return;
    }

    final scrollOffset = bookEntityLocal?.scrollOffset ?? 0.0;

    await _upsertBookToLocal(
      selectedChapterId: selectedChapterId,
      scrollOffset: scrollOffset,
      isFavorite: bookEntityLocal?.isFavorite ?? false,
    );

    _pushScreen(
      isNovel: storyDetailSubject.value!.type.isNovel,
      listChapter: storyDetailSubject.value!.listChapter,
      selectedChapterId: selectedChapterId,
      scrollOffset: scrollOffset,
      storyId: storyId,
    ).then((_) {
      _getBookLocal();
    });
  }

  Future _pushScreen({
    required String storyId,
    required bool isNovel,
    required String selectedChapterId,
    required double scrollOffset,
    required List<ListChapterEntity> listChapter,
  }) async {
    if (isNovel) {
      return routerService.push(
        RouteInput.readStory(
          args: ReadStoryArgument(
            storyId: storyId,
            selectedChapterId: selectedChapterId,
            listChapter: listChapter,
            scrollOffset: scrollOffset,
          ),
        ),
      );
    }

    final comicChapter = listChapter.map(
      (e) {
        return ComicChapterEntity(
          id: e.id,
          name: e.name,
          pages: [],
        );
      },
    ).toList();

    return routerService.push(
      RouteInput.readComic(
        args: ReadComicArgument(
          storyId: storyId,
          selectedChapterId: selectedChapterId,
          listChapter: comicChapter,
          scrollOffset: scrollOffset,
        ),
      ),
    );
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
      final listChapter = storyDetailSubject.value?.listChapter ?? [];
      final bookEntity = BookEntity(
        id: storyId,
        listChapters: listChapter,
        storyData: storyDetailSubject.value!,
        currentChapterId: selectedChapterId,
        scrollOffset: scrollOffset ?? 0.0,
        isFavorite: isFavorite,
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
