import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truyen_cv/dependency/backup/backup_service.dart';
import 'package:truyen_cv/dependency/import_story/import_story_service.dart';
import 'package:truyen_cv/dependency/local_api/local_api_service.dart';
import 'package:truyen_cv/dependency/network_api/network_api_service.dart';
import 'package:truyen_cv/dependency/router/router_provider.dart';
import 'package:truyen_cv/dependency/router/router_service.dart';
import 'package:truyen_cv/dependency/sqflite/sqlite_service.dart';
import 'package:truyen_cv/dependency/toast/toast_service.dart';

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
      final sqfliteService = SqliteService();
      return LocalApiService(
        ref,
        sqfliteService: sqfliteService,
      );
    },
  );

  static final importFile = Provider(
    (ref) {
      return ImportStoryService(
        ref.watch(AppService.localApi).bookRepository,
      );
    },
  );

  static final backup = Provider(
    (ref) {
      return BackupService();
    },
  );

  AppService._();
}
