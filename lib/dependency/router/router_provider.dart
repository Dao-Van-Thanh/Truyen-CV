import 'package:flutter/material.dart';

import 'router_provider_interface.dart';
import 'utils/route_input.dart';

class RouterProvider extends RouterProviderInterface {
  @override
  late final GlobalKey<NavigatorState> navigatorKey;

  NavigatorState? get _navigatorState => navigatorKey.currentState;

  RouterProvider({GlobalKey<NavigatorState>? key}) {
    navigatorKey = key ?? GlobalKey<NavigatorState>();
  }

  @override
  BuildContext get rootContext => _navigatorState!.context;

  @override
  Future<bool> pop<T extends Object>({T? result, BuildContext? context}) {
    return Navigator.of(context ?? rootContext).maybePop(result);
  }

  @override
  void popUntil(RoutePredicate predicate, {BuildContext? context}) {
    Navigator.of(context ?? rootContext).popUntil(predicate);
  }

  @override
  Future<T?> push<T extends Object>(
    RouteInput routeInput, {
    BuildContext? context,
  }) async {
    final result = await Navigator.of(context ?? rootContext).pushNamed(
      routeInput.routeName,
      arguments: routeInput.arguments,
    );
    return result as T?;
  }

  @override
  Future<T?> pushReplacement<T extends Object?>(
    RouteInput routeInput, {
    BuildContext? context,
  }) async {
    final result =
        await Navigator.of(context ?? rootContext).pushReplacementNamed(
      routeInput.routeName,
      arguments: routeInput.arguments,
    );
    return result as T?;
  }

  @override
  Future<T?> pushAndRemoveUntil<T extends Object?>(
    RouteInput routeInput,
    RoutePredicate predicate, {
    BuildContext? context,
  }) async {
    final result =
        await Navigator.of(context ?? rootContext).pushNamedAndRemoveUntil(
      routeInput.routeName,
      predicate,
      arguments: routeInput.arguments,
    );
    return result as T?;
  }

  /// FORCE POP
  @override
  Future<void> forcePop<T extends Object>({
    T? result,
    BuildContext? context,
  }) async {
    return Navigator.of(context ?? rootContext).pop<T>(result);
  }
}
