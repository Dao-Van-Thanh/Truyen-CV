import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/dependency/local_api/repository/book/book_repository.dart';
import 'package:flutter_template/dependency/local_api/repository/chapter/chapter_repository.dart';
import 'package:flutter_template/dependency/local_api/repository/config/config_repository.dart';
import 'package:flutter_template/dependency/local_api/repository/router/router_repository.dart';
import 'package:flutter_template/dependency/local_api/repository/system_config/system_config_repository.dart';
import 'package:flutter_template/dependency/sqflite/sqflite_service.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:sqflite/sqflite.dart';

class LocalApiService {
  Ref ref;
  final SqfliteService _sqfliteService;

  LocalApiService(this.ref, {required SqfliteService sqfliteService})
      : _sqfliteService = sqfliteService;

  FutureOr<Database> get db => _sqfliteService.database;

  Future<void> initDb() async => _sqfliteService.initDB();

  Future<void> closeDb() async => _sqfliteService.close();

  Future<void> deleteDatabaseFile() async =>
      _sqfliteService.deleteDatabaseFile();

  BookRepository get bookRepository => BookRepository(
        db: _sqfliteService.database,
        chapterRepository: chapterRepository,
      );

  ConfigRepository get configRepository =>
      ConfigRepository(db: _sqfliteService.database);

  RouterRepository get routerRepository =>
      RouterRepository(db: _sqfliteService.database);

  SystemConfigRepository get systemConfigRepository =>
      SystemConfigRepository(db: _sqfliteService.database);

  ChapterRepository get chapterRepository =>
      ChapterRepository(db: _sqfliteService.database);

  Future<void> clearUserData() async {
    try {
      final database = await db;

      await database.transaction((txn) async {
        await txn.delete('chapters');
        await txn.delete('routes');
        await txn.delete('books');
      });
      await database.execute('VACUUM');
    } catch (e) {
      logger.e('Error clearing user data: $e');
      rethrow;
    }
  }
}
