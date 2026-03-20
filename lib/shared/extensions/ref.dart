import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truyen_cv/dependency/app_service.dart';
import 'package:truyen_cv/dependency/network_api/network_api_service.dart';
import 'package:truyen_cv/dependency/router/router_service.dart';

extension WidgetRefExtension on WidgetRef {
  RouterService get router => read(AppService.router);

  NetworkApiService get network => read(AppService.networkApi);
}
