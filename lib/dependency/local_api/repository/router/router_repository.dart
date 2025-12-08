import 'package:flutter_template/dependency/local_api/repository/router/entities/router_entity.dart';
import 'package:sqflite/sqflite.dart';

class RouterRepository {
  final Database db;

  RouterRepository({required this.db});

  Future<void> saveCurrentRoute(String routeName, String bookId) async {
    await db.transaction((txn) async {
      await txn.delete('routes');

      await txn.insert('routes', {
        'id': 1,
        'routeName': routeName,
        'bookId': bookId,
        'timeStamp': DateTime.now().toIso8601String(),
      });
    });
  }

  Future<void> clearCurrentRoute() async {
    await db.delete('routes');
  }

  Future<RouteEntity?> getLastRoute() async {
    final List<Map<String, dynamic>> maps = await db.query(
      'routes',
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return RouteEntity.fromMap(maps.first);
    }
    return null;
  }
}
