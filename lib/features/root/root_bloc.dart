import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/shared/widgets/bottom_navigation_bar/enum/bottom_navigation_bar_enum.dart';
import 'package:rxdart/rxdart.dart';

class RootBloc extends BlocBase {
  Ref ref;

  late final routerService = ref.read(AppService.router);

  final selectedNavigationBarSubject =
      BehaviorSubject<BottomNavigationBarEnum>.seeded(
    BottomNavigationBarEnum.library,
  );

  final navigatorKeysMap = BottomNavigationBarEnum.values
      .fold<Map<BottomNavigationBarEnum, GlobalKey<NavigatorState>>>(
    {},
    (previousValue, element) =>
        previousValue..[element] = GlobalKey<NavigatorState>(),
  );

  RootBloc(this.ref);

  @override
  void dispose() {
    super.dispose();
    selectedNavigationBarSubject.close();
  }

  void selectNavigationBar(BottomNavigationBarEnum item) {
    if (item == BottomNavigationBarEnum.explore) {
      routerService.push(RouteInput(routeName: item.initialRoute));
      return;
    }
    selectedNavigationBarSubject.add(item);
  }

  List<BottomNavigationBarEnum> get bottomTabs =>
      BottomNavigationBarEnum.values;
}
