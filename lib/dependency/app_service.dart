import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/dependency/local_api/local_api_service.dart';

import 'package:flutter_template/dependency/network_api/network_api_service.dart';
import 'package:flutter_template/dependency/router/router_provider.dart';
import 'package:flutter_template/dependency/router/router_service.dart';
import 'package:flutter_template/dependency/sqflite/sqflite_service.dart';
import 'package:flutter_template/dependency/toast/toast_service.dart';

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

  static final toast = Provider(
    (ref) {
      return ToastService(ref);
    },
  );

  static final networkApi = Provider(
    (ref) {
      return NetworkApiService(ref);
    },
  );

  static final localApi = Provider(
    (ref) {
      final sqfliteService = SqfliteService();
      return LocalApiService(
        ref,
        sqfliteService: sqfliteService,
      );
    },
  );

  AppService._();
}
