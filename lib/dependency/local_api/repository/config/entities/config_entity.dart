import 'package:flutter_template/features/story/read_story/enum/read_theme_mode.dart';
import 'package:flutter_template/features/story/read_story/model/config_story_model.dart';

class ConfigEntity {
  String id;
  String fontFamily;
  double fontSize;
  String themeMode;
  String timeStamp;
  double lineHeight;

  ConfigEntity({
    this.id = '1',
    required this.fontFamily,
    required this.fontSize,
    required this.themeMode,
    required this.timeStamp,
    required this.lineHeight,
  });

  factory ConfigEntity.fromMap(Map<String, dynamic> map) {
    return ConfigEntity(
      id: map['id'],
      fontFamily: map['fontFamily'],
      fontSize: map['fontSize'],
      themeMode: map['themeMode'],
      timeStamp: map['timeStamp'],
      lineHeight: map['lineHeight'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fontFamily': fontFamily,
      'fontSize': fontSize,
      'themeMode': themeMode,
      'timeStamp': timeStamp,
      'lineHeight': lineHeight,
    };
  }

  ConfigEntity copyWith({
    String? id,
    String? fontFamily,
    double? fontSize,
    String? themeMode,
    String? timeStamp,
    double? lineHeight,
  }) {
    return ConfigEntity(
      id: id ?? this.id,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      themeMode: themeMode ?? this.themeMode,
      timeStamp: timeStamp ?? this.timeStamp,
      lineHeight: lineHeight ?? this.lineHeight,
    );
  }
}

extension ConfigEntityExtension on ConfigEntity {
  ConfigStoryModel toConfigModel() {
    return ConfigStoryModel(
      fontSize: fontSize,
      lineHeight: lineHeight,
      themeMode: ReadThemeMode.fromName(themeMode),
      fontFamily: fontFamily,
    );
  }
}
