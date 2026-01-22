import 'package:flutter/material.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/dependency/router/utils/route_name.dart';
import 'package:flutter_template/dependency/router/utils/route_screen.dart';
import 'package:flutter_template/shared/widgets/dialog/file_import_dialog.dart';

class RoutePage {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final name = settings.name;
    print('onGenerateRoute: $name');

    if (name != null && _isFileIntent(name)) {
      return _buildImportDialogRoute(settings, name);
    }

    return switch (name) {
      RouteName.counter => RouteScreen.counterPageRoute(settings),
      RouteName.root => RouteScreen.rootPageRoute(settings),
      RouteName.explore => RouteScreen.explorePageRoute(settings),
      RouteName.storyDetail => RouteScreen.storyDetailPageRoute(settings),
      RouteName.listChapter => RouteScreen.listChapterPageRoute(settings),
      RouteName.readStory => RouteScreen.readStoryPageRoute(settings),
      RouteName.storySearch => RouteScreen.storySearchPageRoute(settings),
      RouteName.setting => RouteScreen.settingPageRoute(settings),
      _ => RouteScreen.unknownPageRoute(settings),
    };
  }

  static Route<dynamic>? onGenerateLibraryRoute(RouteSettings settings) =>
      settings.name == RouteName.library
          ? RouteScreen.libraryPageRoute(settings)
          : RouteScreen.unknownPageRoute(settings);

  static Route<dynamic>? onGenerateExploreRoute(RouteSettings settings) =>
      RouteScreen.unknownPageRoute(settings);

  static Route<dynamic>? onGenerateIndividualRoute(RouteSettings settings) =>
      settings.name == RouteName.individual
          ? RouteScreen.individualPageRoute(settings)
          : RouteScreen.unknownPageRoute(settings);

  static bool _isFileIntent(String name) {
    final lower = name.toLowerCase();

    final isUriIntent = lower.startsWith('file:') ||
        lower.startsWith('content:') ||
        lower.contains('/document/') ||
        lower.contains('/inbox/');

    final isAbsoluteFilePath = lower.startsWith('/') &&
        CommonConstants.supportedFileExtensions.any(lower.endsWith);

    return isUriIntent || isAbsoluteFilePath;
  }

  static bool _hasValidFileExtension(String name) {
    final lowerName = name.toLowerCase();
    return CommonConstants.supportedFileExtensions
        .any((ext) => lowerName.endsWith(ext));
  }

  static Route<dynamic> _buildImportDialogRoute(
    RouteSettings settings,
    String filePath,
  ) {
    return PageRouteBuilder(
      opaque: false,
      barrierColor: Colors.black54,
      settings: settings,
      pageBuilder: (_, __, ___) => FileImportDialog(filePath: filePath),
      transitionsBuilder: (_, anim, __, child) =>
          FadeTransition(opacity: anim, child: child),
    );
  }
}
