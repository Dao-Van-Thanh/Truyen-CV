import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/constants/config.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/network_api/story/chapter/chapter_response.dart';
import 'package:flutter_template/dependency/network_api/story/detail/story_detail_response.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/dependency/router/arguments/read_story_argument.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/features/story/read_story/enum/read_theme_mode.dart';
import 'package:flutter_template/features/story/read_story/enum/read_tts_status.dart';
import 'package:flutter_template/features/story/read_story/extension/read_story_local_extension.dart';
import 'package:flutter_template/features/story/read_story/extension/read_story_tts_extension.dart';
import 'package:flutter_template/features/story/read_story/helper/tts_timer.dart';
import 'package:flutter_template/features/story/read_story/model/config_story_model.dart';
import 'package:flutter_template/features/story/read_story/model/tts_config_model.dart';
import 'package:flutter_template/features/story/read_story/tts/read_story_tts.dart';
import 'package:flutter_template/features/story/read_story/widgets/read_story_settings.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/extensions/stream.dart';
import 'package:flutter_template/shared/helper/action_confirm.dart';
import 'package:flutter_template/shared/utilities/debounce.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:rxdart/rxdart.dart';

class ReadStoryBloc extends BlocBase {
  Ref ref;
  final ReadStoryArgument _args;

  String get storyId => _args.storyId;
  String get selectedChapterId => _args.selectedChapterId;
  double get scrollOffset => _args.scrollOffset;

  late final networkApiService = ref.read(AppService.networkApi);
  late final routerService = ref.read(AppService.router);
  late final localApiService = ref.read(AppService.localApi);
  late final toastService = ref.read(AppService.toast);
  final currentListChapterItemSubject =
      BehaviorSubject<ListChapterRes?>.seeded(null);
  final isMenuVisibleSubject = BehaviorSubject<bool>.seeded(false);

  final configStorySubject =
      BehaviorSubject<ConfigStoryModel>.seeded(defaultConfigStory);
  final pageController = PageController();

  final isLoadingSubject = BehaviorSubject<bool>.seeded(false);

  final chaptersMapSubject =
      BehaviorSubject<Map<String, ChapterResponse>>.seeded({});
  final ttsControllerStatusSubject = BehaviorSubject<ReadTtsStatus>.seeded(
    ReadTtsStatus.stopped,
  );
  final Debounce _preloadDebounce = Debounce(milliseconds: 300);
  final Debounce reloadTtsStartDebounce = Debounce(milliseconds: 500);
  final tts = ReadStoryTts();
  final ttsConfigSubject = BehaviorSubject<TtsConfig>.seeded(TtsConfig());

  final ActionConfirmHelper _resetConfirmTimer = ActionConfirmHelper();
  final ttsResetSettingsHelper = ActionConfirmHelper();

  final ttsTimerHelper = TtsTimerHelper();

  final timerStringSubject = BehaviorSubject<String>.seeded('');
  final isTimerRunningSubject = BehaviorSubject<bool>.seeded(false);

  final storyDetailSubject = BehaviorSubject<StoryDetailResponse?>.seeded(null);

  final isOpenDrawerSubject = BehaviorSubject<bool>.seeded(false);

  final isFavoriteSubject = BehaviorSubject<bool>.seeded(false);

  final listChapterSubject = BehaviorSubject<List<ListChapterRes>>.seeded([]);

  BuildContext? timerSettingsContext;

  ReadStoryBloc(this.ref, {required ReadStoryArgument args}) : _args = args {
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    saveConfigLocal(configStorySubject.value);
    clearRouterLocal();
    currentListChapterItemSubject.close();
    isMenuVisibleSubject.close();
    configStorySubject.close();
    isLoadingSubject.close();
    ttsConfigSubject.close();
    chaptersMapSubject.close();
    if (pageController.hasClients) {
      pageController.dispose();
    }
    ttsControllerStatusSubject.close();
    _preloadDebounce.dispose();
    reloadTtsStartDebounce.dispose();
    tts.dispose();
    _resetConfirmTimer.dispose();
    ttsResetSettingsHelper.dispose();
    ttsTimerHelper.dispose();
    timerStringSubject.close();
    isTimerRunningSubject.close();
    ttsTimerHelper.dispose();
    storyDetailSubject.close();
    isOpenDrawerSubject.close();
    isFavoriteSubject.close();
    listChapterSubject.close();
  }

  void toggleMenuVisibility() {
    final current = isMenuVisibleSubject.value;
    isMenuVisibleSubject.add(!current);
  }

  void onChangeReadProgress(double value) {
    final pageIndex = value.toInt();
    pageController.jumpToPage(pageIndex);
  }

  void _init() async {
    listChapterSubject.value = _args.listChapter;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listen();
      final selectedIndex = listChapterSubject.value.indexWhere(
        (chapter) => chapter.id == selectedChapterId,
      );
      if (selectedIndex != -1) {
        pageController.jumpToPage(selectedIndex);
        onPageChanged(selectedIndex);
      } else {
        preloadChapters(0);
      }
    });
    _loadStoryDetail();
    isLoadingSubject.value = true;
    await Future.wait([
      getConfigLocal(),
      saveRouterLocal(),
      getFavoriteStatus(),
    ]);
    isLoadingSubject.value = false;
    initTts();
  }

  void onPageChanged(int p1) {
    if (p1 < 0 || p1 >= listChapterSubject.value.length) return;
    currentListChapterItemSubject.value = listChapterSubject.value[p1];
    _preloadDebounce.run(() {
      preloadChapters(p1);
    });
  }

  void onTapNextPage() {
    final currentPage = pageController.page?.toInt() ?? 0;
    if (currentPage < listChapterSubject.value.length - 1) {
      pageController.jumpToPage(
        currentPage + 1,
      );
    }
  }

  void onTaoNextPageToIndex(int index) {
    final currentPage = pageController.page?.toInt() ?? 0;
    if (index >= 0 &&
        index < listChapterSubject.value.length &&
        index != currentPage) {
      pageController.jumpToPage(index);
    }
  }

  void onTapPreviousPage() {
    final currentPage = pageController.page?.toInt() ?? 0;
    if (currentPage > 0) {
      pageController.jumpToPage(
        currentPage - 1,
      );
    }
  }

  void onTapSettings() {
    toggleMenuVisibility();
    showModalBottomSheet(
      context: routerService.rootContext,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return ReadStorySettings();
      },
    );
  }

  void onSelectedThemeMode(ReadThemeMode mode) {
    final currentConfig = configStorySubject.value;
    configStorySubject.add(currentConfig.copyWith(themeMode: mode));
  }

  void onChangeFontSize(double fontSize) {
    final currentConfig = configStorySubject.value;
    configStorySubject.add(currentConfig.copyWith(fontSize: fontSize));
  }

  void onChangeLineHeight(double lineHeight) {
    final currentConfig = configStorySubject.value;
    configStorySubject.add(currentConfig.copyWith(lineHeight: lineHeight));
  }

  void onChangeFontFamily(String? fontFamily) {
    if (fontFamily == null) return;
    final currentConfig = configStorySubject.value;
    configStorySubject.add(currentConfig.copyWith(fontFamily: fontFamily));
  }

  bool isCurrentPage(String? chapterId) {
    if (chapterId == null) return false;
    final currentPageIndex = pageController.page?.toInt();
    if (currentPageIndex == null) return false;
    final currentChapterId = listChapterSubject.value[currentPageIndex].id;
    return chapterId == currentChapterId;
  }

  void onTapResetSetting(BuildContext context) {
    _resetConfirmTimer.execute(
      onFirstTap: () {
        toastService.showText(
          message: t.readStory.resetSettingsToDefaultConfirm,
        );
      },
      onConfirmed: () {
        toastService.showText(
          message: t.readStory.resetSettingsToDefaultSuccess,
        );
        configStorySubject.add(defaultConfigStory);
      },
    );
  }

  Future<void> preloadChapters(int currentIndex) async {
    final List<Future<void>> tasks = [];

    // 1. Xác định Start: (Hiện tại - 2), nhưng không được nhỏ hơn 0
    int start = currentIndex - 2;
    if (start < 0) start = 0;

    // 2. Xác định End: (Hiện tại + 2), nhưng không được vượt quá phần tử cuối
    int end = currentIndex + 2;
    if (end >= listChapterSubject.value.length) {
      end = listChapterSubject.value.length - 1;
    }

    // 3. Loop trong khoảng [start -> end] (Bao gồm cả previous, current, next)
    for (int i = start; i <= end; i++) {
      final chapterItem = listChapterSubject.value[i];

      // Chỉ tải nếu trong Cache CHƯA CÓ
      if (!chaptersMapSubject.value.containsKey(chapterItem.id)) {
        // Lưu ý: task này nên chạy async độc lập,
        // add vào list để dùng Future.wait chờ tất cả (nếu muốn)
        tasks.add(
          _fetchAndCache(
            chapterItem.id ?? '',
          ),
        );
      }
    }

    // 4. Kích hoạt tải đồng thời
    if (tasks.isNotEmpty) {
      await Future.wait(tasks);
    }
  }

  Future<void> _fetchAndCache(String id) async {
    // Gọi Repository tải data
    final res = await _fetchChapter(chapterId: id);
    if (res != null) {
      final currentMap =
          Map<String, ChapterResponse>.from(chaptersMapSubject.value);
      currentMap[id] = res;
      chaptersMapSubject.add(currentMap); // Emit map mới để UI update
    }
  }

  Future<ChapterResponse?> _fetchChapter({
    required String chapterId,
  }) async {
    final res = await networkApiService.storyRepository.getChapter(
      chapterId,
    );
    if (isDispose) return null;
    return res.whenOrNull<ChapterResponse?>(
      success: (data) {
        final chapter = data.data;
        return chapter;
      },
      error: (error) {
        logger.e('Failed to load chapter: $error');
        return null;
      },
    );
  }

  bool onHandleWillPop() {
    if (isMenuVisibleSubject.value) {
      isMenuVisibleSubject.add(false);
      return false;
    }
    return true;
  }

  void onTapToggleDrawer() {
    final current = isOpenDrawerSubject.value;
    isOpenDrawerSubject.add(!current);
    if (isMenuVisibleSubject.value) {
      toggleMenuVisibility();
    }
  }

  Future<void> _loadStoryDetail() async {
    final res = await networkApiService.storyRepository.storyDetail(
      storyId,
    );
    if (isDispose) return;

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

  bool onAfterExitReadStory() {
    final isMenuVisible = isMenuVisibleSubject.value;
    if (isMenuVisible) {
      toggleMenuVisibility();
      return false;
    }

    final isDrawerOpen = isOpenDrawerSubject.value;
    if (isDrawerOpen) {
      onTapToggleDrawer();
      return false;
    }

    return true;
  }

  void onTapNextStoryDetail() {
    routerService.push(
      RouteInput.storyDetail(storyId: storyId),
    );
  }

  void onTapFavoriteStory() async {
    final currentStatus = isFavoriteSubject.value;
    final newStatus = !currentStatus;

    final bookEntityLocal =
        await localApiService.bookRepository.getBookById(storyId);

    final newBookEntity = bookEntityLocal?.copyWith(
      isFavorite: newStatus,
    );

    localApiService.bookRepository
        .upsertBook(
      newBookEntity!,
      isHasUpdateListChapter: false,
    )
        .then((_) {
      if (isDispose) return;
      isFavoriteSubject.value = newStatus;
    });
  }

  Future<void> getFavoriteStatus() async {
    final bookEntityLocal =
        await localApiService.bookRepository.getBookById(storyId);
    final isFavorite = bookEntityLocal?.isFavorite ?? false;
    isFavoriteSubject.value = isFavorite;
  }

  void onTapRefreshChapter() {
    toastService.showText(message: t.readStory.refreshingChapters);
    _loadListChapter().then((newCount) {
      if (isDispose) return;
      toastService.showText(message: t.readStory.refreshChaptersSuccess);
      if (newCount == null || newCount == 0) return;
      final currentIndex = pageController.page?.toInt() ?? 0;
      preloadChapters(currentIndex);
    });
  }

  void onTapLoadNewChapter() {
    toastService.showText(
      message: t.readStory.loadingNewChapters,
    );
    _loadListChapter().then((newCount) {
      if (isDispose) return;
      if (newCount == null || newCount == 0) {
        toastService.showText(
          message: t.readStory.noNewChapters,
        );
      } else {
        toastService.showText(
          message: t.readStory.haveNewChapters(
            count: newCount,
          ),
        );
        final currentIndex = pageController.page?.toInt() ?? 0;
        preloadChapters(currentIndex);
      }
    });
  }

  Future<int?> _loadListChapter() async {
    final res = await networkApiService.storyRepository.getListChapter(storyId);
    if (isDispose) return null;
    return res.whenOrNull<int?>(
      success: (data) {
        final oldList = listChapterSubject.value;
        final newList = data.data!;
        final countNewChapters = newList.length - oldList.length;
        if (countNewChapters > 0) {
          listChapterSubject.value = newList;
        }
        logger.i(
          'oldList length: ${oldList.length}, newList length: ${newList.length}, countNewChapters: $countNewChapters',
        );
        return countNewChapters;
      },
      error: (error) {
        logger.e('ReadStoryBloc _loadListChapter error: ${error.errorMessage}');
        return null;
      },
    );
  }

  void _listen() {
    configStorySubject.bind(ref, (event) {
      final theme = event.themeMode;

      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: theme.statusBarBrightness,
          statusBarBrightness: theme.iosStatusBrightness,
          systemNavigationBarColor: theme.backgroundColor,
          systemNavigationBarIconBrightness: theme.statusBarBrightness,
        ),
      );
    });
  }
}
