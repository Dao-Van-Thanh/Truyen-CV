import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truyen_cv/bloc/bloc_provider.dart';
import 'package:truyen_cv/bloc/rx/obs_builder.dart';
import 'package:truyen_cv/dependency/app_service.dart';
import 'package:truyen_cv/dependency/router/utils/route_name.dart';
import 'package:truyen_cv/dependency/router/utils/route_page.dart';
import 'package:truyen_cv/i18n/strings.g.dart';
import 'package:truyen_cv/shared/bloc/config/app_theme.dart';
import 'package:truyen_cv/shared/utilities/logger.dart';

Future<void> _loadSystemConfigs(ProviderContainer container) async {
  try {
    await container.read(BlocProvider.config).init();
  } catch (e) {
    logger.e('Error initializing services: $e');
  }
}

Future<void> _initLocalServices(ProviderContainer container) async {
  try {
    final localApiService = container.read(AppService.localApi);
    // await localApiService.deleteDatabaseFile();
    await localApiService.initDb();
    await localApiService.configRepository.initDefaultConfig();
  } catch (e) {
    logger.e('Error initializing services: $e');
  }
}

void _addDebugModes() {
  if (!kDebugMode) return;
  // Enable Flutter's debug painting to visualize layout boundaries
  // debugPaintSizeEnabled = true;

  // Enable Flutter's performance overlay to visualize rendering performance
  // WidgetsApp.showPerformanceOverlayOverride = true;

  // Enable Flutter's widget inspector to visualize widget trees
  // debugDumpRenderTree();

  debugRepaintRainbowEnabled = true;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // _addDebugModes();

  final container = ProviderContainer();
  await _initLocalServices(container);
  await _loadSystemConfigs(container);

  // SystemChrome.setPreferredOrientations([
  // DeviceOrientation.portraitUp,
  // ]).then((_) {
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: TranslationProvider(child: const MyApp()),
    ),
  );
  // });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final routerService = ref.watch(AppService.router);
    final configBloc = ref.watch(BlocProvider.config);
    final toastService = ref.watch(AppService.toast);
    final _ = ref.watch(BlocProvider.app); // Initialize AppBloc
    return ObsBuilder(
      streams: [configBloc.themeModeSubject],
      builder: (context) {
        return MaterialApp(
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales:
              AppLocale.values.map((e) => e.flutterLocale).toList(),
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          debugShowCheckedModeBanner: false,
          title: 'Mê truyện CV',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: configBloc.themeModeSubject.value,
          onGenerateRoute: RoutePage.onGenerateRoute,
          navigatorObservers: [
            routerService.routeObserver,
            toastService.observer,
          ],
          navigatorKey: routerService.navigatorKey,
          builder: (context, child) {
            final botToastBuilder = toastService.init();

            final appBuilder = botToastBuilder(context, child);

            if (!Platform.isIOS) {
              return appBuilder;
            }
            // Only apply fixed text scaling if the platform is iOS
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(
                  physics: const ClampingScrollPhysics(),
                ),
                child: appBuilder,
              ),
            );
          },
          initialRoute: RouteName.root,
        );
      },
    );
  }
}
