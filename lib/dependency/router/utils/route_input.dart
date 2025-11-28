import 'package:flutter_template/dependency/router/arguments/explore_argument.dart';

import 'route_name.dart';

class RouteInput {
  String routeName;
  Object? arguments;

  RouteInput({
    required this.routeName,
    this.arguments,
  });

  RouteInput.counter() : routeName = RouteName.counter;
  RouteInput.root() : routeName = RouteName.root;
  RouteInput.unknown() : routeName = RouteName.unknown;
  RouteInput.library() : routeName = RouteName.library;
  RouteInput.explore({
    ExploreArgument? this.arguments,
  }) : routeName = RouteName.explore;
  RouteInput.individual() : routeName = RouteName.individual;
}
