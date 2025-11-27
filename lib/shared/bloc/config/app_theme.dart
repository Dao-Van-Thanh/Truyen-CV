import 'package:flutter/material.dart';

class AppTheme {
  static final String _defaultFont = 'AvertaStdCY';

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: _defaultFont,
    scaffoldBackgroundColor: Colors.grey[50],
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple, brightness: Brightness.light),
    iconTheme: const IconThemeData(color: Colors.black87),
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
    tabBarTheme: const TabBarTheme(
      indicatorColor: Colors.black87,
      labelColor: Colors.black87,
      unselectedLabelColor: Colors.black54,
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: _defaultFont,
    scaffoldBackgroundColor: Colors.grey[900],
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple, brightness: Brightness.dark),
    iconTheme: const IconThemeData(color: Colors.white70),
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
  );
}
