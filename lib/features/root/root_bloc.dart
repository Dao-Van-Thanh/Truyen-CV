import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:truyen_cv/bloc/bloc_base.dart';
import 'package:truyen_cv/bloc/bloc_provider.dart';
import 'package:truyen_cv/dependency/app_service.dart';
import 'package:truyen_cv/dependency/router/arguments/read_story_argument.dart';
import 'package:truyen_cv/dependency/router/utils/route_input.dart';
import 'package:truyen_cv/features/library/extension/library_extension.dart';
import 'package:truyen_cv/shared/extensions/router.dart';
import 'package:truyen_cv/shared/widgets/bottom_navigation_bar/enum/bottom_navigation_bar_enum.dart';

class RootBloc extends BlocBase {
  Ref ref;

  late final routerService = ref.read(AppService.router);
  late final localApiService = ref.read(AppService.localApi);

  final selectedNavigationBarSubject =
      BehaviorSubject<BottomNavigationBarEnum>.seeded(
    BottomNavigationBarEnum.library,
  );

  final navigatorKeysMap = BottomNavigationBarEnum.values
      .fold<Map<BottomNavigationBarEnum, GlobalKey<NavigatorState>>>(
    {},
    (previousValue, element) =>
        previousValue..[element] = GlobalKey<NavigatorState>(),
  );

  bool _isLibraryDirty = false;

  RootBloc(this.ref) {
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    selectedNavigationBarSubject.close();
  }

  void selectNavigationBar(BottomNavigationBarEnum item) {
    if (item == BottomNavigationBarEnum.explore) {
      routerService.push(RouteInput(routeName: item.initialRoute));
      return;
    }
    selectedNavigationBarSubject.add(item);
    if (item == BottomNavigationBarEnum.library) {
      onRefreshLibrary();
    }
  }

  void markLibraryDirty() {
    _isLibraryDirty = true;
  }

  List<BottomNavigationBarEnum> get bottomTabs =>
      BottomNavigationBarEnum.values;

  Future<void> _init() async {
    final routerLocal = await localApiService.routerRepository.getLastRoute();
    if (routerLocal == null) return;
    final bookLocal = await localApiService.bookRepository.getBookById(
      routerLocal.bookId,
    );
    if (bookLocal == null) return;
    routerService.pushReadStory(
      bookLocal.storyData.type,
      args: ReadStoryArgument(
        storyId: bookLocal.id,
        selectedChapterId: bookLocal.currentChapterId ?? '',
        listChapter: bookLocal.listChapters,
        scrollOffset: bookLocal.scrollOffset,
        isOfflineImport: bookLocal.isLocal,
      ),
    );
  }

  void onRefreshLibrary() {
    if (!_isLibraryDirty) return;
    if (selectedNavigationBarSubject.value != BottomNavigationBarEnum.library) {
      return;
    }
    _isLibraryDirty = false;
    Future.delayed(const Duration(milliseconds: 300), () {
      final libraryBloc = ref.read(BlocProvider.library);
      libraryBloc.loadData();
    });
  }
}
