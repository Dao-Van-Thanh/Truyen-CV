import 'package:flutter/material.dart';

import 'package:flutter_template/dependency/router/router_provider_interface.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';

class RouterService {
  final RouterProviderInterface routerInterface;

  RouterService({required this.routerInterface});

  GlobalKey<NavigatorState> get navigatorKey => routerInterface.navigatorKey;

  BuildContext get rootContext => routerInterface.rootContext;

  final RouteObserver<ModalRoute<void>> _routeObserver =
      RouteObserver<ModalRoute<void>>();

  RouteObserver<ModalRoute<void>> get routeObserver => _routeObserver;

  String? get currentPath => _getCurrentPath();

  String? _getCurrentPath() {
    String? currentPath;
    navigatorKey.currentState?.popUntil((route) {
      currentPath = route.settings.name;
      return true;
    });
    return currentPath;
  }

  Future<void> pop<T extends Object>({T? result, BuildContext? context}) {
    return routerInterface.pop(result: result, context: context);
  }

  void popUntil(RoutePredicate predicate, {BuildContext? context}) {
    routerInterface.popUntil(predicate, context: context);
  }

  Future<T?> push<T extends Object>(
    RouteInput routeInput, {
    BuildContext? context,
  }) async {
    return routerInterface.push(routeInput, context: context);
  }

  Future<T?> pushReplacement<T extends Object?>(
    RouteInput routeInput, {
    BuildContext? context,
  }) async {
    return routerInterface.pushReplacement(routeInput, context: context);
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(
    RouteInput routeInput,
    RoutePredicate predicate, {
    BuildContext? context,
  }) async {
    return routerInterface.pushAndRemoveUntil(
      routeInput,
      predicate,
      context: context,
    );
  }

  Future<void> forcePop<T extends Object>({T? result, BuildContext? context}) {
    return routerInterface.forcePop(result: result, context: context);
  }
}
