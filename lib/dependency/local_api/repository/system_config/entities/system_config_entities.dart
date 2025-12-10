import 'package:flutter/material.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/widgets/story_list/enum/story_list_type.dart';

class SystemConfigEntities {
  final String? id;
  final ThemeMode themeMode; // 'light', 'dark', 'system'
  final StoryListType typeListDisplay; // 'list', 'grid'
  final AppLocale locale; // 'vi', 'en'
  final DateTime? timeStamp;

  SystemConfigEntities({
    this.id,
    required String themeMode,
    required String typeListDisplay,
    required String locale,
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
      themeMode: map['themeMode'] as String? ?? 'system', // Default value
      typeListDisplay: map['typeListDisplay'] as String? ?? 'list',
      locale: map['locale'] as String? ?? 'vi',
      timeStamp: map['timeStamp'] != null
          ? DateTime.tryParse(map['timeStamp'] as String)
          : null,
    );
  }

  // Convert từ Object -> DB Map
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Thường sẽ để null để Auto Increment hoặc fix cứng = 1
      'themeMode': themeMode.name,
      'typeListDisplay': typeListDisplay.name,
      'locale': locale.languageCode,
      'timeStamp': timeStamp?.toIso8601String(),
    };
  }

  // Hàm copyWith để update tiện lợi
  SystemConfigEntities copyWith({
    String? id,
    String? themeMode,
    String? typeListDisplay,
    String? locale,
    DateTime? timeStamp,
  }) {
    return SystemConfigEntities(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode.name,
      typeListDisplay: typeListDisplay ?? this.typeListDisplay.name,
      locale: locale ?? this.locale.languageCode,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }
}
