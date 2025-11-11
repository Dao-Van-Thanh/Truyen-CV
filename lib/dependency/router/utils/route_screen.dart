import 'package:flutter/material.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/features/counter/counter_bloc.dart';
import 'package:flutter_template/features/counter/counter_screen.dart';
import 'package:flutter_template/features/unknown/unknown_screen.dart';

class RouteScreen {
  static PageRoute counterPageRoute(RouteSettings settings) {
    BlocProvider.counter = createAutoDisposeBloc(
      (ref) => CounterBloc(ref),
    );
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const CounterScreen(),
    );
  }

  static PageRoute unknownPageRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const UnknownScreen(),
    );
  }
}
