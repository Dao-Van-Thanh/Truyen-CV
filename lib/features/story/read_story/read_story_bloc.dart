import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/network_api/story/chapter/chapter_response.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/dependency/router/arguments/read_story_argument.dart';
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
import 'package:flutter_template/shared/helper/action_confirm.dart';
import 'package:flutter_template/shared/utilities/debounce.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:rxdart/rxdart.dart';

class ReadStoryBloc extends BlocBase {
  Ref ref;
  ReadStoryArgument args;

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

  ReadStoryBloc(this.ref, {required this.args}) {
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedIndex = args.listChapter.indexWhere(
        (chapter) => chapter.id == args.selectedChapterId,
      );
      if (selectedIndex != -1) {
        pageController.jumpToPage(selectedIndex);
        handlePageChanged(selectedIndex);
      } else {
        preloadChapters(0);
      }
    });
    isLoadingSubject.value = true;
    await Future.wait([
      getConfigLocal(),
      saveRouterLocal(),
    ]);
    isLoadingSubject.value = false;
    initTts();
  }

  void handlePageChanged(int p1) {
    if (p1 < 0 || p1 >= args.listChapter.length) return;
    currentListChapterItemSubject.value = args.listChapter[p1];
    _preloadDebounce.run(() {
      preloadChapters(p1);
    });
  }

  void onTapNextPage() {
    final currentPage = pageController.page?.toInt() ?? 0;
    if (currentPage < args.listChapter.length - 1) {
      pageController.jumpToPage(
        currentPage + 1,
      );
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
    final currentChapterId = args.listChapter[currentPageIndex].id;
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
    final listChapter = args.listChapter;
    final List<Future<void>> tasks = [];

    // 1. Xác định Start: (Hiện tại - 2), nhưng không được nhỏ hơn 0
    int start = currentIndex - 2;
    if (start < 0) start = 0;

    // 2. Xác định End: (Hiện tại + 2), nhưng không được vượt quá phần tử cuối
    int end = currentIndex + 2;
    if (end >= listChapter.length) end = listChapter.length - 1;

    // 3. Loop trong khoảng [start -> end] (Bao gồm cả previous, current, next)
    for (int i = start; i <= end; i++) {
      final chapterItem = listChapter[i];

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
}
