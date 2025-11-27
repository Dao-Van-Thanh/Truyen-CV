import 'package:flutter/material.dart';
import 'package:flutter_template/dependency/router/utils/route_name.dart';
import 'package:flutter_template/i18n/strings.g.dart';

enum BottomNavigationBarEnum {
  library(initialRoute: RouteName.library),
  explore(initialRoute: RouteName.explore),
  individual(initialRoute: RouteName.individual);

  final String initialRoute;

  const BottomNavigationBarEnum({required this.initialRoute});
}

extension BottomNavigationBarEnumExtension on BottomNavigationBarEnum {
  String label(BuildContext context) {
    final t = context.t;
    switch (this) {
      case BottomNavigationBarEnum.library:
        return t.rootScreen.bottomNavigationBar.library;
      case BottomNavigationBarEnum.explore:
        return t.rootScreen.bottomNavigationBar.explore;
      case BottomNavigationBarEnum.individual:
        return t.rootScreen.bottomNavigationBar.individual;
    }
  }

  Widget get icon {
    switch (this) {
      case BottomNavigationBarEnum.library:
        return const Icon(Icons.library_books_outlined);
      case BottomNavigationBarEnum.explore:
        return const Icon(Icons.explore_outlined);
      case BottomNavigationBarEnum.individual:
        return const Icon(Icons.person_outline);
    }
  }
}
