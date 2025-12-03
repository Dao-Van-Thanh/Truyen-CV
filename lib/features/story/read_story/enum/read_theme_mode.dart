import 'package:flutter/cupertino.dart';

enum ReadThemeMode {
  light(
    backgroundColor: Color(0xFFFFFFFF),
    textColor: Color(0xFF000000),
  ),
  dark(
    backgroundColor: Color(0xFF121212),
    textColor: Color(0xFFFFFFFF),
  ),
  sepia(
    backgroundColor: Color(0xFFF4ECD8),
    textColor: Color(0xFF5B4636),
  );

  final Color backgroundColor;
  final Color textColor;

  const ReadThemeMode({
    required this.backgroundColor,
    required this.textColor,
  });
}
