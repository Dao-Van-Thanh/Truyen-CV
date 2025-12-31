import 'package:flutter_template/features/story/read_story/enum/read_theme_mode.dart';

class ConfigStoryModel {
  final double fontSize;
  final double lineHeight;
  final ReadThemeMode themeMode;
  final String fontFamily;

  ConfigStoryModel({
    required this.fontSize,
    required this.lineHeight,
    required this.themeMode,
    required this.fontFamily,
  });

  ConfigStoryModel copyWith({
    double? fontSize,
    double? lineHeight,
    ReadThemeMode? themeMode,
    String? fontFamily,
  }) {
    return ConfigStoryModel(
      fontSize: fontSize ?? this.fontSize,
      lineHeight: lineHeight ?? this.lineHeight,
      themeMode: themeMode ?? this.themeMode,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }
}


