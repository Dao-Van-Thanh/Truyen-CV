import 'package:flutter/material.dart';
import 'route_name.dart';
import 'route_screen.dart';

class RoutePage {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.counter:
        return RouteScreen.counterPageRoute(settings);
    }

    return RouteScreen.unknownPageRoute(settings);
  }
}
