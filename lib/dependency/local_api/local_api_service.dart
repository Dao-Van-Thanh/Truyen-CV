import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/dependency/sqflite/sqflite_service.dart';
import 'package:sqflite/sqflite.dart';

class LocalApiService {
  Ref ref;
  SqfliteService _sqfliteService;

  LocalApiService(this.ref, {required SqfliteService sqfliteService})
      : _sqfliteService = sqfliteService;

  FutureOr<Database> get db => _sqfliteService.database ;

  Future<void> initDb() async => _sqfliteService.initDB;
}
