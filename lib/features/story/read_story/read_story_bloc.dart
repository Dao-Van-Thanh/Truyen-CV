import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/dependency/router/arguments/read_story_argument.dart';
import 'package:flutter_template/features/story/read_story/enum/read_theme_mode.dart';
import 'package:flutter_template/features/story/read_story/extension/read_story_local_extension.dart';
import 'package:flutter_template/features/story/read_story/model/config_story_model.dart';
import 'package:flutter_template/features/story/read_story/widgets/read_story_settings.dart';
import 'package:flutter_template/i18n/strings.g.dart';
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

  Timer? _resetConfirmTimer;

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
    if (pageController.hasClients) {
      pageController.dispose();
    }
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
      }
    });
    isLoadingSubject.value = true;
    await Future.wait([
      getConfigLocal(),
      saveRouterLocal(),
    ]);
    isLoadingSubject.value = false;
  }

  void handlePageChanged(int p1) {
    if (p1 < 0 || p1 >= args.listChapter.length) return;
    currentListChapterItemSubject.value = args.listChapter[p1];
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
    if (_resetConfirmTimer != null && _resetConfirmTimer!.isActive) {
      _resetConfirmTimer?.cancel();
      _resetConfirmTimer = null;
      toastService.showText(message: t.readStory.resetSettingsToDefaultSuccess);
      configStorySubject.add(defaultConfigStory);
      return;
    }

    _resetConfirmTimer = Timer(const Duration(seconds: 3), () {
      _resetConfirmTimer = null;
    });
    toastService.showText(message: t.readStory.resetSettingsToDefaultConfirm);
  }
}
