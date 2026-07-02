import 'package:flutter/cupertino.dart';
import 'package:truyen_cv/shared/extensions/color.dart';

const double _alpha = 0.95;

enum ReadThemeMode {
  // Classic
  light(
    backgroundColor: Color(0xFFFAFAF7),
    textColor: Color(0xFF202124),
  ),
  dark(
    backgroundColor: Color(0xFF171717),
    textColor: Color(0xFFD8D8D8),
  ),
  amoledBlack(
    backgroundColor: Color(0xFF000000),
    textColor: Color(0xFFC8C8C8),
  ),

  // Paper
  sepia(
    backgroundColor: Color(0xFFF0DFC0),
    textColor: Color(0xFF4B3528),
  ),
  warmPaper(
    backgroundColor: Color(0xFFFBF3E2),
    textColor: Color(0xFF37312A),
  ),
  parchment(
    backgroundColor: Color(0xFFE4D4B5),
    textColor: Color(0xFF3D2F23),
  ),
  newsprint(
    backgroundColor: Color(0xFFE6E3DC),
    textColor: Color(0xFF252525),
  ),
  eInk(
    backgroundColor: Color(0xFFD6D3CA),
    textColor: Color(0xFF1E1E1E),
  ),

  // Eye care
  mintEyeCare(
    backgroundColor: Color(0xFFDCEBDD),
    textColor: Color(0xFF233528),
  ),
  forestDark(
    backgroundColor: Color(0xFF17241D),
    textColor: Color(0xFFC2D2BE),
  ),
  blueLightFilter(
    backgroundColor: Color(0xFFF4DFC3),
    textColor: Color(0xFF3F2F25),
  ),
  blossom(
    backgroundColor: Color(0xFFF9E9E7),
    textColor: Color(0xFF52343A),
  ),

  // Dark
  midnightBlue(
    backgroundColor: Color(0xFF101820),
    textColor: Color(0xFFD7E3EA),
  ),
  deepPurple(
    backgroundColor: Color(0xFF211C2D),
    textColor: Color(0xFFE0D7EC),
  ),
  slate(
    backgroundColor: Color(0xFF202A32),
    textColor: Color(0xFFD7DEE3),
  ),
  hacker(
    backgroundColor: Color(0xFF0E1511),
    textColor: Color(0xFF94B690),
  ),
  royal(
    backgroundColor: Color(0xFF201C24),
    textColor: Color(0xFFE6D8BC),
  );

  final Color backgroundColor;
  final Color textColor;

  // Hàm này giúp tạo màu cho Appbar/BottomBar trùng tông nhưng đậm hơn chút
  // để tạo chiều sâu giao diện
  Color get backgroundControllerColor =>
      backgroundColor.withValues(alpha: _alpha).darkenColor();

  Brightness get statusBarBrightness {
    if (backgroundColor.computeLuminance() < 0.5) {
      return Brightness.light;
    } else {
      return Brightness.dark;
    }
  }

  Brightness get iosStatusBrightness => statusBarBrightness == Brightness.light
      ? Brightness.dark
      : Brightness.light;

  static ReadThemeMode fromName(String name) {
    return ReadThemeMode.values.firstWhere(
      (mode) => mode.name == name,
      orElse: () => ReadThemeMode.light,
    );
  }

  const ReadThemeMode({
    required this.backgroundColor,
    required this.textColor,
  });
}
