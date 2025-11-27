import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'network_api/network_api_service.dart';
import 'router/router_provider.dart';
import 'router/router_service.dart';

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
