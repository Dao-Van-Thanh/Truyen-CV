import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/shared/widgets/story_list/enum/story_list_type.dart';
import 'package:rxdart/rxdart.dart';

class AppConfigBloc extends BlocBase {
  Ref ref;

  late final localApiService = ref.read(AppService.localApi);
  final themeModeSubject = BehaviorSubject<ThemeMode>.seeded(ThemeMode.system);
  final typeListDisplaySubject =
      BehaviorSubject<StoryListType>.seeded(StoryListType.list);

  AppConfigBloc(this.ref) {
    _init();
  }

  @override
  void dispose() {
    themeModeSubject.close();
    typeListDisplaySubject.close();
    super.dispose();
  }

  void onChangeThemeMode(ThemeMode mode) {
    themeModeSubject.add(mode);
  }

  void onChangeTypeListDisplay(StoryListType type) {
    if (type == typeListDisplaySubject.value) return;
    typeListDisplaySubject.add(type);
    localApiService.systemConfigRepository.updateTypeListDisplay(type.name);
  }

  ThemeMode get currentThemeMode => themeModeSubject.value;

  void onToggleThemeMode() {
    final currentMode = themeModeSubject.value;
    ThemeMode newMode;
    switch (currentMode) {
      case ThemeMode.light:
        newMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        newMode = ThemeMode.system;
        break;
      case ThemeMode.system:
        newMode = ThemeMode.light;
        break;
    }
    themeModeSubject.add(newMode);
  }

  Future<void> _init() async {
    final systemConfig =
        await localApiService.systemConfigRepository.getConfig();
    if (isDispose) return;
    themeModeSubject.value = systemConfig?.themeMode ?? ThemeMode.system;
    typeListDisplaySubject.value =
        systemConfig?.typeListDisplay ?? StoryListType.list;
  }
}
