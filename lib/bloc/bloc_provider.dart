import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/shared/bloc/app_bloc.dart';
import 'package:flutter_template/shared/bloc/theme/app_theme_bloc.dart';

class BlocProvider {
  static final app = Provider((ref) => AppBloc(ref));
  static final appTheme = Provider((ref) => AppThemeBloc(ref));
  static late AutoDisposeProvider counter;
}
