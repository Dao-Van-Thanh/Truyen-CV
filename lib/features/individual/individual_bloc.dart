import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truyen_cv/bloc/bloc_base.dart';
import 'package:truyen_cv/dependency/app_service.dart';
import 'package:truyen_cv/dependency/router/utils/route_input.dart';

class IndividualBloc extends BlocBase {
  Ref ref;

  IndividualBloc(this.ref);

  void onTapSetting() {
    ref.read(AppService.router).push(RouteInput.setting());
  }

  void onTapBackup() {
    ref.read(AppService.router).push(RouteInput.backup());
  }
}
