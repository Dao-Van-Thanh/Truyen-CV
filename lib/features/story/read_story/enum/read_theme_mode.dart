import 'package:flutter/cupertino.dart';
import 'package:flutter_template/shared/extensions/color.dart';

const double _alpha = 0.95;

enum ReadThemeMode {
  // ==========================================
  // 1. CLASSIC & CLEAN (Cơ bản & Sạch sẽ)
  // ==========================================
  light(
    backgroundColor: Color(0xFFFAFAFA), // Off-white, dịu hơn trắng tinh
    textColor: Color(0xFF1A1A1A), // Đen than (Charcoal), đỡ gắt hơn #000
  ),
  dark(
    backgroundColor: Color(0xFF121212), // Chuẩn Material Dark
    textColor: Color(0xFFE0E0E0), // Xám sáng, độ tương phản chuẩn WCAG
  ),
  amoledBlack(
    backgroundColor:
        Color(0xFF000000), // Đen tuyệt đối cho màn OLED tiết kiệm pin
    textColor: Color(
      0xFFB3B3B3,
    ), // Xám trung tính, tránh hiện tượng "bóng ma" (smearing) khi cuộn
  ),

  // ==========================================
  // 2. PAPER & NOSTALGIA (Giấy & Hoài cổ)
  // ==========================================
  sepia(
    backgroundColor: Color(0xFFF5E6C8), // Vàng giấy cũ ấm áp
    textColor: Color(0xFF4E342E), // Nâu đậm (Coffee), hài hòa với nền vàng
  ),
  warmPaper(
    backgroundColor: Color(0xFFFDF6E3), // Solarized Light Base (trắng ngà)
    textColor: Color(0xFF383A42), // Xám mực in
  ),
  parchment(
    backgroundColor: Color(0xFFE3DCC2), // Giấy da cừu, hơi trầm hơn Sepia
    textColor: Color(0xFF3D2C20), // Nâu đất tối
  ),
  newsprint(
    backgroundColor: Color(0xFFDCDCDC), // Giấy báo xám
    textColor: Color(0xFF212121), // Đen mực in báo
  ),
  eInk(
    backgroundColor:
        Color(0xFFC4C2BC), // Mô phỏng màn hình Kindle (xám xi măng nhạt)
    textColor: Color(0xFF0F0F0F), // Đen sâu
  ),

  // ==========================================
  // 3. EYE CARE & NATURE (Bảo vệ mắt & Thiên nhiên)
  // ==========================================
  mintEyeCare(
    backgroundColor: Color(0xFFC7EDCC), // Xanh đậu (Eye protection standard)
    textColor: Color(0xFF003300), // Xanh rêu đậm, đọc rất êm
  ),
  forestDark(
    backgroundColor: Color(0xFF1A261C), // Rừng đêm (Xanh đen)
    textColor: Color(0xFFAABFA5), // Xanh bạc hà nhạt (Sage green)
  ),
  blueLightFilter(
    backgroundColor: Color(0xFFF6E6C9), // Hổ phách (Night shift)
    textColor: Color(0xFF3E2723), // Nâu tối
  ),
  blossom(
    backgroundColor: Color(0xFFFFF0F5), // Lavender Blush (Hồng phấn nhẹ)
    textColor: Color(0xFF5C3A44), // Đỏ tía đậm (Plum), sang trọng
  ),

  // ==========================================
  // 4. MODERN DARK & HIGH CONTRAST (Tối hiện đại)
  // ==========================================
  midnightBlue(
    backgroundColor: Color(0xFF15202B), // Twitter Dim (Xanh than)
    textColor: Color(0xFFF5F8FA), // Trắng hơi xanh
  ),
  deepPurple(
    backgroundColor: Color(0xFF1E1B2E), // Tím than sâu (Deep Space)
    textColor: Color(0xFFDCD6F7), // Tím oải hương nhạt
  ),
  slate(
    backgroundColor: Color(0xFF263238), // Blue Grey 900
    textColor: Color(0xFFECEFF1), // Blue Grey 50
  ),
  hacker(
    backgroundColor: Color(0xFF0A0F0D), // Đen hơi xanh lục (Matrix style)
    textColor:
        Color(0xFF20C20E), // Xanh lá Terminal (đã giảm độ chói so với neon gốc)
  ),
  royal(
    backgroundColor: Color(0xFF212121), // Xám than chì
    textColor: Color(0xFFFFD700), // Vàng Gold (Sang trọng, vương giả)
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
