import 'package:flutter_template/constants/config.dart';
import 'package:flutter_template/dependency/local_api/repository/system_config/entities/system_config_entities.dart';
import 'package:flutter_template/features/explore/enum/explore_navigation_enum.dart';
import 'package:sqflite/sqflite.dart';

class SystemConfigRepository {
  final Database db;

  static const String _tableName = 'system_configs';
  static const String _colId = 'id';

  SystemConfigRepository({required this.db});

  Future<SystemConfigEntities?> getConfig() async {
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      limit: 1, // Chỉ lấy 1 dòng đầu tiên
    );

    if (maps.isNotEmpty) {
      return SystemConfigEntities.fromMap(maps.first);
    }
    return null;
  }

  Future<void> saveConfig(SystemConfigEntities config) async {
    final map = config.toMap();
    map[_colId] = 1;

    await db.insert(
      _tableName,
      map,
      // Quan trọng: Nếu ID=1 đã tồn tại -> Update. Nếu chưa -> Insert
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTheme(String newThemeMode) async {
    final currentConfig = await getConfig();

    if (currentConfig != null) {
      final newConfig = currentConfig.copyWith(
        themeMode: newThemeMode,
        timeStamp: DateTime.now(),
      );
      await saveConfig(newConfig);
    } else {
      final newConfig = SystemConfigEntities(
        themeMode: newThemeMode,
        typeListDisplay: defaultSystemConfig.typeListDisplay.name, // Default
        locale: defaultSystemConfig.locale.languageCode, // Default
        timeStamp: DateTime.now(),
      );
      await saveConfig(newConfig);
    }
  }

  // update list type display
  Future<void> updateTypeListDisplay(String newTypeListDisplay) async {
    final currentConfig = await getConfig();
    if (currentConfig != null) {
      final newConfig = currentConfig.copyWith(
        typeListDisplay: newTypeListDisplay,
        timeStamp: DateTime.now(),
      );
      await saveConfig(newConfig);
    } else {
      final newConfig = SystemConfigEntities(
        themeMode: defaultSystemConfig.themeMode.name, // Default
        typeListDisplay: newTypeListDisplay,
        locale: defaultSystemConfig.locale.languageCode, // Default
        timeStamp: DateTime.now(),
      );
      await saveConfig(newConfig);
    }
  }

  // update locale
  Future<void> updateLocale(String newLocale) async {
    final currentConfig = await getConfig();
    if (currentConfig != null) {
      final newConfig = currentConfig.copyWith(
        locale: newLocale,
        timeStamp: DateTime.now(),
      );
      await saveConfig(newConfig);
    } else {
      final newConfig = SystemConfigEntities(
        themeMode: defaultSystemConfig.themeMode.name, // Default
        typeListDisplay: defaultSystemConfig.typeListDisplay.name, // Default
        locale: newLocale,
        timeStamp: DateTime.now(),
      );
      await saveConfig(newConfig);
    }
  }

  // update explore navigation tab
  Future<void> updateExploreNavigationTab(
    ExploreNavigationEnum newExploreNavigationTab,
  ) async {
    final currentConfig = await getConfig();
    if (currentConfig != null) {
      final newConfig = currentConfig.copyWith(
        exploreNavigationTab: newExploreNavigationTab,
        timeStamp: DateTime.now(),
      );
      await saveConfig(newConfig);
    } else {
      final newConfig = SystemConfigEntities(
        themeMode: defaultSystemConfig.themeMode.name, // Default
        typeListDisplay: defaultSystemConfig.typeListDisplay.name, // Default
        locale: defaultSystemConfig.locale.languageCode, // Default
        exploreNavigationTab: newExploreNavigationTab,
        timeStamp: DateTime.now(),
      );
      await saveConfig(newConfig);
    }
  }
}
