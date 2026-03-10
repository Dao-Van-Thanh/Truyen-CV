import 'package:flutter/material.dart';
import 'package:flutter_template/dependency/router/utils/route_name.dart';
import 'package:flutter_template/i18n/strings.g.dart';

enum ExploreNavigationEnum {
  novel(initialRoute: RouteName.exploreNovel),
  comic(initialRoute: RouteName.exploreComic);

  final String initialRoute;
  const ExploreNavigationEnum({required this.initialRoute});

  factory ExploreNavigationEnum.fromRouteName(String? routeName) {
    return switch (routeName) {
      RouteName.exploreNovel => ExploreNavigationEnum.novel,
      RouteName.exploreComic => ExploreNavigationEnum.comic,
      (_) => ExploreNavigationEnum.novel
    };
  }
}

extension ExploreNavigationEnumExtension on ExploreNavigationEnum {
  String get displayName {
    return switch (this) {
      ExploreNavigationEnum.novel => t.exploreScreen.type.novel,
      ExploreNavigationEnum.comic => t.exploreScreen.type.comic
    };
  }

  Widget get icon {
    return switch (this) {
      ExploreNavigationEnum.novel => Icon(Icons.auto_stories),
      ExploreNavigationEnum.comic => Icon(Icons.photo_library)
    };
  }
}
