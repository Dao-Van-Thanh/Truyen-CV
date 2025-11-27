import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class AppConfigBloc extends BlocBase {
  Ref ref;

  final themeModeSubject = BehaviorSubject<ThemeMode>.seeded(ThemeMode.system);

  AppConfigBloc(this.ref);

  @override
  void dispose() {
    themeModeSubject.close();
    super.dispose();
  }

  void onChangeThemeMode(ThemeMode mode) {
    themeModeSubject.add(mode);
  }

  ThemeMode get currentThemeMode => themeModeSubject.value;

  void onToggleThemeMode() {
    final currentMode = themeModeSubject.value;
    ThemeMode newMode;
    switch (currentMode) {
      case ThemeMode.light:
        newMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        newMode = ThemeMode.system;
        break;
      case ThemeMode.system:
        newMode = ThemeMode.light;
        break;
    }
    themeModeSubject.add(newMode);
  }
}
