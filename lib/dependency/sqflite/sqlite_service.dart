import 'dart:async';

import 'package:truyen_cv/constants/common.dart';
import 'package:truyen_cv/dependency/sqflite/schema.dart';
import 'package:truyen_cv/shared/utilities/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const int sqliteVersion = 5;

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
    await _createIndexes(db);
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(SqfliteSchema.addIsLocalToBooks);
      await db.execute(SqfliteSchema.createChapterContentsTable);
    }

    if (oldVersion < 3) {
      await db.execute(SqfliteSchema.addExploreNavigationTabToSystemConfigs);
    }

    if (oldVersion < 4) {
      await db.execute(SqfliteSchema.addOrderIndexToChapters);
    }

    if (oldVersion < 5) {
      await _createIndexes(db);
    }
  }

  Future<void> _createIndexes(Database db) async {
    await Future.wait([
      db.execute(SqfliteSchema.createChaptersBookIdIndex),
      db.execute(SqfliteSchema.createChapterContentsChapterIdIndex),
      db.execute(SqfliteSchema.createRoutesBookIdIndex),
    ]);
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
