import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/network_api/network_api_service.dart';
import 'package:flutter_template/dependency/router/router_service.dart';

extension WidgetRefExtension on WidgetRef {
  RouterService get router => read(AppService.router);

  NetworkApiService get network => read(AppService.networkApi);
}
