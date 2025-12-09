import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/router/utils/route_page.dart';
import 'package:flutter_template/shared/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:flutter_template/shared/widgets/bottom_navigation_bar/enum/bottom_navigation_bar_enum.dart';

class RootScreen extends ConsumerStatefulWidget {
  const RootScreen({super.key});

  @override
  ConsumerState<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends ConsumerState<RootScreen> with RouteAware {
  late final routeService = ref.read(AppService.router);
  late final bloc = ref.watch(BlocProvider.root);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    routeService.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeService.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    bloc.onRefreshLibrary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: bloc.bottomTabs.map((tab) {
          return ObsBuilder(
            streams: [bloc.selectedNavigationBarSubject],
            builder: (ctx) => Offstage(
              offstage: tab != bloc.selectedNavigationBarSubject.value,
              child: Navigator(
                key: bloc.navigatorKeysMap[tab],
                onGenerateRoute: buildRouteFactory(tab),
                initialRoute: tab.initialRoute,
              ),
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }

  RouteFactory buildRouteFactory(BottomNavigationBarEnum tab) {
    switch (tab) {
      case BottomNavigationBarEnum.library:
        return RoutePage.onGenerateLibraryRoute;
      case BottomNavigationBarEnum.explore:
        return RoutePage.onGenerateExploreRoute;
      case BottomNavigationBarEnum.individual:
        return RoutePage.onGenerateIndividualRoute;
    }
  }
}
