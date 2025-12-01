import 'package:flutter/material.dart';
import 'route_name.dart';
import 'route_screen.dart';

class RoutePage {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.counter:
        return RouteScreen.counterPageRoute(settings);
      case RouteName.root:
        return RouteScreen.rootPageRoute(settings);
      case RouteName.explore:
        return RouteScreen.explorePageRoute(settings);
      case RouteName.storyDetail:
        return RouteScreen.storyDetailPageRoute(settings);
      case RouteName.listChapter:
        return RouteScreen.listChapterPageRoute(settings);
    }

    return RouteScreen.unknownPageRoute(settings);
  }

  static Route<dynamic>? onGenerateLibraryRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.library:
        return RouteScreen.libraryPageRoute(settings);
    }

    return RouteScreen.unknownPageRoute(settings);
  }

  static Route<dynamic>? onGenerateExploreRoute(RouteSettings settings) {
    return RouteScreen.unknownPageRoute(settings);
  }

  static Route<dynamic>? onGenerateIndividualRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.individual:
        return RouteScreen.individualPageRoute(settings);
    }

    return RouteScreen.unknownPageRoute(settings);
  }
}
