import 'package:flutter/cupertino.dart';
import 'package:flutter_template/shared/extensions/color.dart';

const double _alpha = 0.95;

enum ReadThemeMode {
  light(
    backgroundColor: Color(0xFFFFFFFF),
    textColor: Color(0xFF000000),
  ),
  dark(
    backgroundColor: Color(0xFF121212), // Material Dark
    textColor: Color(0xFFE0E0E0), // Không dùng trắng tinh (FFFFFF) để đỡ chói
  ),
  sepia(
    backgroundColor: Color(0xFFF4ECD8), // Màu giấy cũ tiêu chuẩn
    textColor: Color(0xFF5B4636),
  ),

  warmPaper(
    backgroundColor: Color(0xFFFDF6E3), // Giấy trắng ngà (Solarized Light Base)
    textColor: Color(0xFF333333),
  ),
  parchment(
    backgroundColor: Color(0xFFEFE8D0), // Giấy da cừu (Hơi tối hơn Sepia)
    textColor: Color(0xFF4A3828),
  ),
  newsprint(
    backgroundColor: Color(0xFFDCDCDC), // Giấy báo xám
    textColor: Color(0xFF2C2C2C),
  ),
  eInk(
    backgroundColor: Color(0xFFC9C7BF), // Mô phỏng màn hình Kindle E-ink
    textColor: Color(0xFF111111),
  ),

  // --- EYE CARE (Bảo vệ mắt - Ánh sáng xanh thấp) ---
  mintEyeCare(
    backgroundColor:
        Color(0xFFC7EDCC), // Màu xanh đậu (Phổ biến ở app truyện Trung Quốc)
    textColor: Color(0xFF003300),
  ),
  blueLightFilter(
    backgroundColor: Color(0xFFF6E6C9), // Màu hổ phách nhẹ (Night Shift style)
    textColor: Color(0xFF3E2723),
  ),
  blossom(
    backgroundColor: Color(0xFFFFF0F5), // Màu hồng phấn nhẹ (Lavender blush)
    textColor: Color(0xFF5A2D3C),
  ),

  // --- DARK MODE VARIATIONS (Chế độ tối nâng cao) ---
  midnightBlue(
    backgroundColor:
        Color(0xFF15202B), // Xanh đen (Twitter Dark Mode) - Dịu hơn đen tuyền
    textColor: Color(0xFFF5F8FA),
  ),
  forestDark(
    backgroundColor: Color(0xFF1A261C), // Xanh rừng tối - Rất thư giãn cho mắt
    textColor: Color(0xFFB3CBB5), // Màu xanh bạc hà nhạt
  ),
  amoledBlack(
    backgroundColor:
        Color(0xFF000000), // Đen tuyệt đối (Tiết kiệm pin màn OLED)
    textColor:
        Color(0xFFB0B0B0), // Xám nhạt (Tránh Ghosting khi cuộn trên OLED)
  ),
  deepPurple(
    backgroundColor: Color(0xFF18122B), // Tím than đậm (Dracula style)
    textColor: Color(0xFFE6E6FA),
  ),

  // --- MODERN & HIGH CONTRAST ---
  slate(
    backgroundColor: Color(0xFF2C3E50), // Xám xanh đá phiến
    textColor: Color(0xFFECF0F1),
  ),
  solarizedDark(
    backgroundColor: Color(0xFF002B36), // Bảng màu Solarized nổi tiếng
    textColor: Color(0xFF839496), // Độ tương phản hoàn hảo cho mắt
  ),
  hacker(
    backgroundColor: Color(0xFF0D1117), // GitHub Dark Dimmed
    textColor: Color(0xFF00FF41), // Xanh lá neon (Retro Terminal)
  ),
  royal(
    backgroundColor: Color(0xFF202020), // Xám đậm
    textColor: Color(0xFFD4AF37), // Màu vàng kim loại (Gold)
  );

  final Color backgroundColor;
  final Color textColor;

  Color get backgroundControllerColor =>
      backgroundColor.withValues(alpha: _alpha).darkenColor();

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
