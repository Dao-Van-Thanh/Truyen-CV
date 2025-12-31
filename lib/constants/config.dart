import 'package:flutter/material.dart';
import 'package:flutter_template/dependency/local_api/repository/system_config/entities/system_config_entities.dart';
import 'package:flutter_template/features/story/read_story/enum/read_theme_mode.dart';
import 'package:flutter_template/features/story/read_story/model/config_story_model.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/widgets/story_list/enum/story_list_type.dart';

final defaultConfigStory = ConfigStoryModel(
  fontSize: 16.0,
  lineHeight: 1.5,
  themeMode: ReadThemeMode.light,
  fontFamily: 'AvertaStdCY',
);

final defaultSystemConfig = SystemConfigEntities(
  themeMode: ThemeMode.system.name,
  typeListDisplay: StoryListType.list.name,
  locale: AppLocale.vi.languageCode,
);
