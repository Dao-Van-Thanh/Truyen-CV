import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_template/dependency/network_api/network_api_service.dart';
import 'package:flutter_template/dependency/router/router_provider.dart';
import 'package:flutter_template/dependency/router/router_service.dart';

class AppProvider {
  static final router = Provider((ref) => RouterProvider());
}

class AppService {
  static final router = Provider(
    (ref) {
      return RouterService(
        routerInterface: ref.watch(AppProvider.router),
      );
    },
  );

  static final networkApi = Provider(
    (ref) {
      return NetworkApiService(ref);
    },
  );

  AppService._();
}
