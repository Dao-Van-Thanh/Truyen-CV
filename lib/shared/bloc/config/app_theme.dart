import 'package:flutter/material.dart';

class AppTheme {
  static final String _defaultFont = 'AvertaStdCY';

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    fontFamily: _defaultFont,
    scaffoldBackgroundColor: Colors.grey[50],
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.grey[50]!,
      brightness: Brightness.light,
    ),
    iconTheme: const IconThemeData(color: Colors.black87, size: 20),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black87,
      unselectedItemColor: Colors.black54,
      selectedIconTheme: IconThemeData(size: 20),
      unselectedIconTheme: IconThemeData(size: 20),
      selectedLabelStyle: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
      bodyMedium: TextStyle(fontSize: 14, height: 1.4, color: Colors.black87),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
    tabBarTheme: TabBarTheme(
      indicatorColor: Colors.black87,
      labelColor: Colors.black87,
      unselectedLabelColor: Colors.black54,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black87,
        size: 20,
      ),
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      scrolledUnderElevation: 0,
    ),
    cardColor: Colors.grey[100],
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.white,
      iconColor: Colors.black87,
      textStyle: const TextStyle(color: Colors.black87),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.black87,
      foregroundColor: Colors.white70,
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    fontFamily: _defaultFont,
    scaffoldBackgroundColor: Colors.grey[900],
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.grey[900]!,
      brightness: Brightness.dark,
    ),
    iconTheme: const IconThemeData(color: Colors.white70, size: 20),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black87,
      selectedItemColor: Colors.white70,
      unselectedItemColor: Colors.white70,
      selectedIconTheme: IconThemeData(size: 20),
      unselectedIconTheme: IconThemeData(size: 20),
      selectedLabelStyle: TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, height: 1.5, color: Colors.white70),
      bodyMedium: TextStyle(fontSize: 14, height: 1.4, color: Colors.white70),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
    tabBarTheme: const TabBarTheme(
      indicatorColor: Colors.white70,
      labelColor: Colors.white70,
      unselectedLabelColor: Colors.white54,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black87,
      foregroundColor: Colors.white70,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white70,
        size: 20,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white70,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      scrolledUnderElevation: 0,
    ),
    cardColor: Colors.grey[800],
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.grey[800],
      iconColor: Colors.white70,
      textStyle: const TextStyle(color: Colors.white70),
      iconSize: 20,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white70,
      foregroundColor: Colors.black87,
    ),
  );
}
