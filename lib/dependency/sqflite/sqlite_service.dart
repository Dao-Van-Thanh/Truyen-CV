import 'dart:async';

import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/dependency/sqflite/schema.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const int sqliteVersion = 2;

class SqliteService {
  SqliteService();

  late Database _database;
  Database get database => _database;

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, CommonConstants.dbName);

    _database = await openDatabase(
      path,
      version: sqliteVersion,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
      onConfigure: (db) {
        db.execute('PRAGMA foreign_keys = ON');
      },
    );

    return _database;
  }

  Future _createDB(Database db, int version) async {
    await Future.wait([
      db.execute(SqfliteSchema.createConfigsTable),
      db.execute(SqfliteSchema.createSystemConfigsTable),
      db.execute(SqfliteSchema.createBooksTable),
    ]);
    await Future.wait([
      db.execute(SqfliteSchema.createRouterTable),
      db.execute(SqfliteSchema.createChaptersTable),
    ]);
    await Future.wait([
      db.execute(SqfliteSchema.createChapterContentsTable),
    ]);
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(SqfliteSchema.addIsLocalToBooks);
      await db.execute(SqfliteSchema.createChapterContentsTable);
    }
  }

  Future<void> close() async {
    final db = database;
    return db.close();
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, CommonConstants.dbName);
    await deleteDatabase(path);
    logger.i('Database file deleted at $path');
  }
}
