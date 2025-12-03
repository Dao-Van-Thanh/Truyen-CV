import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/dependency/router/arguments/read_story_argument.dart';
import 'package:flutter_template/features/story/read_story/enum/read_theme_mode.dart';
import 'package:flutter_template/features/story/read_story/widgets/read_story_settings.dart';
import 'package:rxdart/rxdart.dart';

class ReadStoryBloc extends BlocBase {
  Ref ref;
  ReadStoryArgument args;

  late final networkApiService = ref.read(AppService.networkApi);
  late final routerService = ref.read(AppService.router);

  final currentListChapterItemSubject =
      BehaviorSubject<ListChapterRes?>.seeded(null);
  final isMenuVisibleSubject = BehaviorSubject<bool>.seeded(false);

  final themeModeSubject =
      BehaviorSubject<ReadThemeMode>.seeded(ReadThemeMode.dark);
  final pageController = PageController();

  ReadStoryBloc(this.ref, {required this.args}) {
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    currentListChapterItemSubject.close();
    isMenuVisibleSubject.close();
    themeModeSubject.close();
    if (pageController.hasClients) {
      pageController.dispose();
    }
  }

  void toggleMenuVisibility() {
    final current = isMenuVisibleSubject.value;
    isMenuVisibleSubject.add(!current);
  }

  void onChangeReadProgress(double value) {}

  void _init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedIndex = args.listChapter.indexWhere(
        (chapter) => chapter.id == args.selectedChapterId,
      );
      if (selectedIndex != -1) {
        pageController.jumpToPage(selectedIndex);
      }
    });
  }

  void handlePageChanged(int p1) {
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
    showModalBottomSheet(
      context: routerService.rootContext,
      builder: (context) {
        return ReadStorySettings();
      },
    );
  }
}
