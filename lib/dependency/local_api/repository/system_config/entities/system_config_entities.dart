import 'package:flutter/material.dart';
import 'package:truyen_cv/features/explore/enum/explore_navigation_enum.dart';
import 'package:truyen_cv/i18n/strings.g.dart';
import 'package:truyen_cv/shared/widgets/story_list/enum/story_list_type.dart';

class SystemConfigEntities {
  final String? id;
  final ThemeMode themeMode; // 'light', 'dark', 'system'
  final StoryListType typeListDisplay; // 'list', 'grid'
  final AppLocale locale; // 'vi', 'en'
  final ExploreNavigationEnum exploreNavigationTab; // 'novel', 'comic'
  final DateTime? timeStamp;

  SystemConfigEntities({
    this.id,
    required String themeMode,
    required String typeListDisplay,
    required String locale,
    this.exploreNavigationTab = ExploreNavigationEnum.novel,
    this.timeStamp,
  })  : themeMode = switch (themeMode) {
          'light' => ThemeMode.light,
          'dark' => ThemeMode.dark,
          _ => ThemeMode.system,
        },
        typeListDisplay = StoryListType.fromName(typeListDisplay),
        locale = switch (locale) {
          'en' => AppLocale.en,
          _ => AppLocale.vi,
        };

  // Convert từ DB Map -> Object
  factory SystemConfigEntities.fromMap(Map<String, dynamic> map) {
    return SystemConfigEntities(
      id: map['id'] as String?,
      themeMode: map['themeMode'] as String? ?? 'system',
      typeListDisplay: map['typeListDisplay'] as String? ?? 'list',
      locale: map['locale'] as String? ?? 'vi',
      exploreNavigationTab: ExploreNavigationEnum.fromRouteName(
        map['exploreNavigationTab'] as String?,
      ),
      timeStamp: map['timeStamp'] != null
          ? DateTime.tryParse(map['timeStamp'] as String)
          : null,
    );
  }

  // Convert từ Object -> DB Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'themeMode': themeMode.name,
      'typeListDisplay': typeListDisplay.name,
      'locale': locale.languageCode,
      'exploreNavigationTab': exploreNavigationTab.initialRoute,
      'timeStamp': timeStamp?.toIso8601String(),
    };
  }

  // Hàm copyWith để update tiện lợi
  SystemConfigEntities copyWith({
    String? id,
    String? themeMode,
    String? typeListDisplay,
    String? locale,
    ExploreNavigationEnum? exploreNavigationTab,
    DateTime? timeStamp,
  }) {
    return SystemConfigEntities(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode.name,
      typeListDisplay: typeListDisplay ?? this.typeListDisplay.name,
      locale: locale ?? this.locale.languageCode,
      exploreNavigationTab: exploreNavigationTab ?? this.exploreNavigationTab,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }
}
