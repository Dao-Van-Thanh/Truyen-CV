import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/dependency/local_api/repository/book/book_repository.dart';
import 'package:flutter_template/dependency/local_api/repository/config/config_repository.dart';
import 'package:flutter_template/dependency/sqflite/sqflite_service.dart';
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

  BookRepository get bookRepository =>
      BookRepository(db: _sqfliteService.database);

  ConfigRepository get configRepository =>
      ConfigRepository(db: _sqfliteService.database);
}
