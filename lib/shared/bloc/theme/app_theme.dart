// lib/dependency/theme/app_theme.dart
import 'dart:io';

import 'package:flutter/material.dart';

class AppTheme {
  static final String _defaultFont = Platform.isIOS ? 'SF Pro' : 'Roboto';

  // Light Theme
  static ThemeData light = ThemeData(
    fontFamily: _defaultFont,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey[50], // nền sáng, dịu mắt
    primaryColor: Colors.deepPurple,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
      bodyMedium: TextStyle(fontSize: 14, height: 1.4, color: Colors.black87),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      iconTheme: IconThemeData(color: Colors.black87),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );

  // Dark Theme
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    fontFamily: _defaultFont,
    scaffoldBackgroundColor: Colors.grey[900], // nền tối nhẹ
    primaryColor: Colors.deepPurple[200],
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, height: 1.5, color: Colors.white70),
      bodyMedium: TextStyle(fontSize: 14, height: 1.4, color: Colors.white70),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.grey[900],
      foregroundColor: Colors.white70,
      iconTheme: const IconThemeData(color: Colors.white70),
    ),
    cardTheme: CardTheme(
      color: Colors.grey[850],
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple[200],
        foregroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
