import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:flutter_template/dependency/router/arguments/list_chapter_argument.dart';
import 'package:flutter_template/dependency/router/arguments/read_story_argument.dart';
import 'package:flutter_template/dependency/router/arguments/story_detail_argument.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/features/story/detail/entities/story_detail_entity.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:rxdart/rxdart.dart';

class StoryDetailBloc extends BlocBase {
  Ref ref;

  late StoryDetailArgument _args;

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
    _getBookLocal();
    loadStoryDetail();
    _listeners();
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
      storyData: storyDetailSubject.value,
      storyName: storyDetailSubject.value?.name ?? '',
    );
    routerService.push(RouteInput.listChapter(args: args));
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
        await localApiService.bookRepository.getBookById(_args.storyId);

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
      logger.e('No chapter available to read for storyId: ${_args.storyId}');
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
          storyId: _args.storyId,
          selectedChapterId: selectedChapterId,
          listChapter: storyDetailSubject.value?.listChapter ?? [],
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
    final res = await localApiService.bookRepository.getBookById(_args.storyId);
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
        id: _args.storyId,
        listChapters: listChapter,
        storyData: jsonEncode(storyDetailSubject.value?.toJson()),
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
        await localApiService.bookRepository.getBookById(_args.storyId);

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
