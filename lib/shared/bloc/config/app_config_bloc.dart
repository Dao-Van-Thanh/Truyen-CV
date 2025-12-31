import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/constants/config.dart';
import 'package:flutter_template/constants/font_family_enum.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/widgets/story_list/enum/story_list_type.dart';
import 'package:rxdart/rxdart.dart';

class AppConfigBloc extends BlocBase {
  Ref ref;

  late final localApiService = ref.read(AppService.localApi);

  // --- System Configs Streams ---
  final themeModeSubject = BehaviorSubject<ThemeMode>.seeded(ThemeMode.system);
  final typeListDisplaySubject =
      BehaviorSubject<StoryListType>.seeded(StoryListType.list);
  final localeSubject = BehaviorSubject<AppLocale>.seeded(AppLocale.vi);

  // --- Reader Configs Streams ---
  final fontSizeSubject = BehaviorSubject<double>.seeded(18.0);
  final lineHeightSubject = BehaviorSubject<double>.seeded(1.5);
  final fontFamilySubject =
      BehaviorSubject<FontFamilyEnum>.seeded(FontFamilyEnum.system);

  ThemeMode get currentThemeMode => themeModeSubject.value;

  StreamSubscription? _localeSubscription;

  AppConfigBloc(this.ref) {
    _init();
  }

  @override
  void dispose() {
    themeModeSubject.close();
    typeListDisplaySubject.close();
    localeSubject.close();
    fontSizeSubject.close();
    lineHeightSubject.close();
    fontFamilySubject.close();
    _localeSubscription?.cancel();
    super.dispose();
  }

  void onChangeThemeMode(ThemeMode mode) {
    if (mode == themeModeSubject.value) return;
    themeModeSubject.add(mode);
    localApiService.systemConfigRepository.updateTheme(mode.name);
  }

  void onChangeTypeListDisplay(StoryListType type) {
    if (type == typeListDisplaySubject.value) return;
    typeListDisplaySubject.add(type);
    localApiService.systemConfigRepository.updateTypeListDisplay(type.name);
  }

  void onChangeLocale(AppLocale locale) {
    if (locale == localeSubject.value) return;
    localeSubject.add(locale);
    localApiService.systemConfigRepository.updateLocale(locale.languageCode);
  }

  // --- Reader Configs Logic ---

  void onChangeFontSize(double size) {
    if (size == fontSizeSubject.value) return;
    fontSizeSubject.add(size);
    localApiService.configRepository.updateFontSize(size);
  }

  void onChangeLineHeight(double height) {
    if (height == lineHeightSubject.value) return;
    lineHeightSubject.add(height);
    localApiService.configRepository.updateLineHeight(height);
  }

  void onChangeFontFamily(FontFamilyEnum font) {
    if (font == fontFamilySubject.value) return;
    fontFamilySubject.add(font);
    localApiService.configRepository.updateFontFamily(font.familyName);
  }

  Future<void> _init() async {
    // 1. Load System Config
    final systemConfig =
        await localApiService.systemConfigRepository.getConfig();
    if (!isDispose && systemConfig != null) {
      themeModeSubject.value = systemConfig.themeMode;
      typeListDisplaySubject.value = systemConfig.typeListDisplay;
      localeSubject.value = systemConfig.locale;
    } else {
      themeModeSubject.value = defaultSystemConfig.themeMode;
      typeListDisplaySubject.value = defaultSystemConfig.typeListDisplay;
      localeSubject.value = defaultSystemConfig.locale;
    }

    // 2. Load Reader Config
    final readerConfig = await localApiService.configRepository.getConfig();
    if (!isDispose && readerConfig != null) {
      fontSizeSubject.value = readerConfig.fontSize;
      lineHeightSubject.value = readerConfig.lineHeight;
      fontFamilySubject.value =
          FontFamilyEnum.fromString(readerConfig.fontFamily);
    } else {
      fontSizeSubject.value = defaultConfigStory.fontSize;
      lineHeightSubject.value = defaultConfigStory.lineHeight;
      fontFamilySubject.value =
          FontFamilyEnum.fromString(defaultConfigStory.fontFamily);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listenToChanges();
    });
  }

  void _listenToChanges() {
    _localeSubscription = localeSubject.stream.listen((locale) {
      LocaleSettings.setLocale(locale);
    });
  }

  void clearAllData() {
    localApiService.clearUserData().catchError((error) {
      ref.read(AppService.toast).showText(
            message: t.setting.deleteDataError(error: error.toString()),
          );
    }).whenComplete(() {
      ref.read(AppService.toast).showText(message: t.setting.deleteDataSuccess);
      ref.read(BlocProvider.library).refreshData();
    });
  }
}
