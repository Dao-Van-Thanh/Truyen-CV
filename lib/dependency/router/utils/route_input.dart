import 'route_name.dart';

class RouteInput {
  String routeName;
  Object? arguments;

  RouteInput({
    required this.routeName,
    this.arguments,
  });

  RouteInput.counter() : routeName = RouteName.counter;
}
