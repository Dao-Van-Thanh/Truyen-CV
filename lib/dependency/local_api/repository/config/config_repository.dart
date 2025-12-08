import 'package:flutter_template/dependency/local_api/repository/config/entities/config_entity.dart';
import 'package:flutter_template/features/story/read_story/model/config_story_model.dart';
import 'package:sqflite/sqflite.dart';

class ConfigRepository {
  final Database db;

  ConfigRepository({required this.db});

  Future<ConfigEntity?> getConfig() async {
    final List<Map<String, dynamic>> maps = await db.query(
      'configs',
      where: 'id = ?',
      whereArgs: ['1'],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return ConfigEntity.fromMap(maps.first);
    }
    return null;
  }

  Future<int> saveConfig(ConfigEntity config) async {
    return db.insert(
      'configs',
      config.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> initDefaultConfig() async {
    final currentConfig = await getConfig();
    if (currentConfig == null) {
      final defaultConfig = ConfigEntity(
        id: '1', // Cố định ID là 1 để dễ quản lý single row
        fontFamily: defaultConfigStory.fontFamily,
        fontSize: defaultConfigStory.fontSize,
        themeMode: defaultConfigStory.themeMode.name,
        timeStamp: DateTime.now().toIso8601String(),
        lineHeight: defaultConfigStory.lineHeight,
      );
      await saveConfig(defaultConfig);
    }
  }

  Future<int> deleteConfig(int id) async {
    return db.delete(
      'configs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
