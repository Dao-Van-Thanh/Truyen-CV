# 📖 Truyện CV — Ứng dụng đọc truyện Flutter

[![Flutter](https://img.shields.io/badge/Flutter-3.6.0+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.6.0+-0175C2?logo=dart)](https://dart.dev)
[![Riverpod](https://img.shields.io/badge/Riverpod-2.6.1-purple)](https://riverpod.dev)

---

## 🧠 Giới thiệu

Truyện CV là một ứng dụng Flutter để đọc truyện chữ với trải nghiệm mượt mà, quản lý dữ liệu cục bộ và hỗ trợ đa ngôn ngữ. Dự án được tổ chức theo mô-đun tính năng, quản lý trạng thái bằng Riverpod + Rx (BLoC), kèm hệ thống điều hướng tùy biến.

---

## ✨ Tính năng chính

- **Thư viện**: lưu dấu trang và lịch sử đọc.
- **Khám phá**: duyệt và tìm kiếm truyện.
- **Chi tiết truyện**: xem thông tin truyện, chương.
- **Đọc truyện**: trình đọc tối ưu, có điều khiển, lớp nền và ngăn kéo tùy chỉnh.
- **Text-to-Speech (TTS)**: đọc truyện bằng giọng nói (dựa trên `flutter_tts`).
- **Đa ngôn ngữ**: tích hợp i18n bằng `slang` + `slang_flutter`.
- **Chủ đề sáng/tối**: chuyển đổi `Theme` theo cấu hình.

---

## 🏗 Kiến trúc

- **UI (Screen)** tách biệt logic, tương tác qua BLoC (`Subject/Stream`).
- **Dịch vụ** tập trung trong `AppService` (router, toast, local API...).
- **Điều hướng**: tập trung ở `RoutePage`/`RouteScreen` với tham số type-safe.
- **Lưu trữ cục bộ**: cơ sở dữ liệu SQLite (`sqflite`).

Sơ đồ luồng tổng quát: UI → BLoC → Service → API/Storage (quan sát bằng `ObsBuilder`).

---

## 🧩 Công nghệ & thư viện

- **Flutter** 3.6+, **Dart** 3.6+
- **Riverpod** (DI & state), **RxDart** (Streams), BLoC tự quản lý vòng đời.
- **Dio** cho kết nối API.
- **slang** cho i18n, **freezed/json_serializable** cho model.
- **sqflite** (DB), **cached_network_image** (cache ảnh), **bot_toast**.

---

## 📁 Cấu trúc thư mục (rút gọn)

```
lib/
├── main.dart                      # Khởi động app, theme, router, i18n
├── bloc/                          # BLoC base, provider, ObsBuilder
├── constants/                     # Màu sắc, spacing, typography, regex...
├── dependency/                    # AppService, Router, API
│   └── router/utils/              # RouteName, RoutePage, RouteScreen
├── features/                      # Từng tính năng (library, explore, story...)
│   └── story/read_story/          # UI đọc truyện & controller
└── shared/                        # Widgets, logger, theme...
```

Tham khảo thêm trong các tệp: [lib/dependency/router/utils/route_page.dart](lib/dependency/router/utils/route_page.dart), [lib/dependency/router/utils/route_screen.dart](lib/dependency/router/utils/route_screen.dart), [lib/dependency/router/utils/route_name.dart](lib/dependency/router/utils/route_name.dart).

---

## 🛠 Cài đặt

- **Yêu cầu**: Flutter 3.6+, Dart 3.6+, macOS/iOS cần CocoaPods.

1) Cài dependencies:

```bash
flutter pub get
```

2) Sinh mã (codegen) nếu có thay đổi model/i18n:

```bash
dart run build_runner build --delete-conflicting-outputs
```

3) iOS (macOS):

```bash
cd ios
pod install
cd ..
```

---

## 🚀 Chạy ứng dụng

Hãy thêm 1 file **env_model.release.dart** (như file **env_model.example.dart**) vào thư mục /lib/shared/env/

```bash
flutter run
```

Chọn thiết bị:

```bash
flutter devices
flutter run -d <device_id>
```

---

## 📦 Build

- Android APK (release):

```bash
flutter build apk --release \
  --target-platform android-arm,android-arm64,android-x64
```

- Build tối ưu (obfuscate + split debug info):

```bash
flutter build apk --release \
  --target-platform android-arm,android-arm64,android-x64 \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols
```

- iOS (macOS):

```bash
flutter clean &&
flutter pub get &&
cd ios && pod install && cd ..
flutter build ios --release
```

<!-- ---

## 🚢 Triển khai nhanh (deploy)

Script tự động cập nhật `build-number`, build APK và tạo GitHub Release bằng **GitHub CLI**:

```bash
./deploy.sh
```

Yêu cầu đã đăng nhập `gh` và có quyền tạo release.

--- -->

## 🧰 Lệnh hữu ích

- Watch codegen:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

- Sửa lint & format:

```bash
dart fix --apply && dart format .
```

- Clean build_runner:

```bash
dart run build_runner clean
```

- Cài đặt APK vào thiết bị:

```bash
flutter install
```

Xem thêm: [COMMAND.md](COMMAND.md).
<!-- 
---

## 🔐 SSL Pinning

- Tạo fingerprint SHA-256 từ chứng chỉ máy chủ:

```bash
make sha256_cert url=https://api.example.com:443
```

- Thêm chuỗi SHA-256 vào biến môi trường `certificateSHA256s` rồi rebuild.

Chi tiết: [SSL_PINNING_GUIDE.md](SSL_PINNING_GUIDE.md).

--- -->

## 📚 Tham khảo

- Flutter: https://docs.flutter.dev/
- Riverpod: https://riverpod.dev/
- RxDart: https://pub.dev/packages/rxdart
- Dio: https://pub.dev/packages/dio
- sqflite: https://pub.dev/packages/sqflite

---

## 🎨 Credits & Góp ý

Giao diện (UI) của **dự án này** được lấy cảm hứng từ App **[vBook]** (chỉ mang tính tham khảo).  
Mã nguồn của dự án này là **mã nguồn mở**, phục vụ mục đích học tập và sử dụng nội bộ.  
Mọi góp ý hoặc đề xuất tính năng đều được hoan nghênh thông qua Issues/PR.
