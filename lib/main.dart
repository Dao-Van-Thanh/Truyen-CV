import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/shared/bloc/config/app_theme.dart';
import 'dependency/app_service.dart';
import 'dependency/router/utils/route_name.dart';
import 'dependency/router/utils/route_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: TranslationProvider(child: const MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final routerService = ref.watch(AppService.router);
    final configBloc = ref.watch(BlocProvider.config);
    return ObsBuilder(
      streams: [configBloc.themeModeSubject],
      builder: (context) {
        return MaterialApp(
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales:
              AppLocale.values.map((e) => e.flutterLocale).toList(),
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: configBloc.themeModeSubject.value,
          onGenerateRoute: RoutePage.onGenerateRoute,
          navigatorKey: routerService.navigatorKey,
          builder: (context, child) {
            if (child == null) return const SizedBox.shrink();

            if (!Platform.isIOS) {
              return child;
            }
            // Only apply fixed text scaling if the platform is iOS
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(
                  physics: const ClampingScrollPhysics(),
                ),
                child: child,
              ),
            );
          },
          initialRoute: RouteName.root,
        );
      },
    );
  }
}
