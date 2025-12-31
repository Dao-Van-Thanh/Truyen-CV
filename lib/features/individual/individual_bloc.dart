import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';

class IndividualBloc extends BlocBase {
  Ref ref;

  IndividualBloc(this.ref);

  void onTapSetting() {
    ref.read(AppService.router).push(RouteInput.setting());
  }
}
