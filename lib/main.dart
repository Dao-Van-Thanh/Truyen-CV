import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dependency/app_service.dart';
import 'dependency/router/utils/route_name.dart';
import 'dependency/router/utils/route_page.dart';

void main() {
  final container = ProviderContainer();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final routerService = ref.watch(AppService.router);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: RoutePage.onGenerateRoute,
      navigatorKey: routerService.navigatorKey,
      initialRoute: RouteName.counter,
    );
  }
}
