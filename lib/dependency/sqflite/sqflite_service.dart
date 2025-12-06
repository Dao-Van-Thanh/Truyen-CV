import 'dart:async';

import 'package:flutter_template/dependency/sqflite/schema.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String _dbName = 'reading_app.db';

class SqfliteService {
  SqfliteService();

  late Database _database;
  Database get database => _database;

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );

    return _database;
  }

  Future _createDB(Database db, int version) async {
    await Future.wait([
      db.execute(SqfliteSchema.createConfigsTable),
      db.execute(SqfliteSchema.createSystemConfigsTable),
      db.execute(SqfliteSchema.createBooksTable),
    ]);
    await db.execute(SqfliteSchema.createRouterTable);
  }

  Future<void> close() async {
    final db = await database;
    return db.close();
  }
}
