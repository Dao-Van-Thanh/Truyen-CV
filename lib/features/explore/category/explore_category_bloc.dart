import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/router/arguments/explore_category_argument.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';

class ExploreCategoryBloc extends BlocBase {
  Ref ref;
  ExploreCategoryArgument args;

  late final routerService = ref.read(AppService.router);

  ExploreCategoryBloc(this.ref, {required this.args});

  void onTapSearch() {
    routerService.push(
      RouteInput.storySearch(),
    );
  }
}
