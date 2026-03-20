import 'package:flutter/material.dart';
import 'package:truyen_cv/dependency/local_api/repository/system_config/entities/system_config_entities.dart';
import 'package:truyen_cv/features/explore/enum/explore_navigation_enum.dart';
import 'package:truyen_cv/features/story/read_story/enum/read_theme_mode.dart';
import 'package:truyen_cv/features/story/read_story/model/config_story_model.dart';
import 'package:truyen_cv/i18n/strings.g.dart';
import 'package:truyen_cv/shared/widgets/story_list/enum/story_list_type.dart';

final defaultStoryConfig = ConfigStoryModel(
  fontSize: 16.0,
  lineHeight: 1.5,
  themeMode: ReadThemeMode.light,
  fontFamily: 'AvertaStdCY',
);

final defaultSystemConfig = SystemConfigEntities(
  themeMode: ThemeMode.system.name,
  typeListDisplay: StoryListType.list.name,
  locale: AppLocale.vi.languageCode,
  exploreNavigationTab: ExploreNavigationEnum.novel,
);
