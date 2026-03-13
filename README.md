# 📖 Truyện CV — Ứng dụng đọc truyện Flutter

[![Flutter](https://img.shields.io/badge/Flutter-3.27.0-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.6.0+-0175C2?logo=dart)](https://dart.dev)
[![Riverpod](https://img.shields.io/badge/Riverpod-2.6.1-purple)](https://riverpod.dev)

---

## 🧠 Giới thiệu

Truyện CV là một ứng dụng Flutter để đọc truyện (novel/comic) với trải nghiệm mượt mà, quản lý dữ liệu cục bộ, hỗ trợ đa ngôn ngữ, import truyện offline và sao lưu/khôi phục dữ liệu. Dự án được tổ chức theo mô-đun tính năng, quản lý trạng thái bằng Riverpod + Rx (BLoC), kèm hệ thống điều hướng tùy biến.

---

## ✨ Tính năng chính

- **Thư viện**: lưu dấu trang và lịch sử đọc.
- **Khám phá**: duyệt và tìm kiếm truyện.
- **Chi tiết truyện**: xem thông tin truyện, chương.
- **Đọc truyện**: trình đọc tối ưu, có điều khiển, lớp nền và ngăn kéo tùy chỉnh.
- **Đọc comic**: trình đọc ảnh toàn màn hình, có controller và drawer chương.
- **Text-to-Speech (TTS)**: đọc truyện bằng giọng nói (dựa trên `flutter_tts`).
- **Import truyện offline**: thêm truyện từ file `.epub`/`.txt` vào thư viện.
- **Backup/Restore**: xuất/nhập dữ liệu SQLite dạng `.zip` (phục vụ chuyển máy/khôi phục).
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

- **Flutter** 3.27.0 (pin qua FVM), **Dart** 3.6+
- **Riverpod** (DI & state), **RxDart** (Streams), BLoC tự quản lý vòng đời.
- **Dio** cho kết nối API.
- **slang** cho i18n, **freezed/json_serializable** cho model.
- **sqflite** (DB), **cached_network_image** (cache ảnh), **bot_toast**.
- **file_picker** (chọn file import), **epub_parser/html** (parse EPUB), **archive/share_plus** (backup zip).

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
│   ├── individual/backup/         # Backup/Restore DB
│   ├── story/read_story/          # UI đọc truyện chữ & controller/TTS
│   └── story/read_comic/          # UI đọc comic (ảnh) & controller/drawer
└── shared/                        # Widgets, logger, theme...
```

Tham khảo thêm trong các tệp: [lib/dependency/router/utils/route_page.dart](lib/dependency/router/utils/route_page.dart), [lib/dependency/router/utils/route_screen.dart](lib/dependency/router/utils/route_screen.dart), [lib/dependency/router/utils/route_name.dart](lib/dependency/router/utils/route_name.dart).

---

## 🛠 Cài đặt

- **Yêu cầu**: Flutter theo `.fvmrc` (hiện tại `3.27.0`), Dart 3.6+, macOS/iOS cần CocoaPods.

Khuyến nghị dùng **FVM** để đồng bộ phiên bản Flutter:

```bash
fvm install
fvm flutter --version
```

1) Cài dependencies:

```bash
fvm flutter pub get
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

Chỉnh cấu hình endpoint và SSL pins (nếu dùng) tại: `lib/shared/env/env_model.release.dart`.

```bash
fvm flutter run
```

Chọn thiết bị:

```bash
fvm flutter devices
fvm flutter run -d <device_id>
```

---

## 📥 Import truyện offline (.epub/.txt)

- Mở **Thư viện** → chọn **Thêm truyện** → chọn file `.epub` hoặc `.txt`.
- Truyện import sẽ được lưu vào DB cục bộ và xuất hiện trong Thư viện (có thể xoá khỏi Thư viện khi không cần).

---

## 💾 Backup/Restore dữ liệu

- Vào mục **Backup** (tab Cá nhân/Individual).
- **Export**: xuất DB SQLite thành file `.zip` (Android sẽ hỏi nơi lưu, iOS sẽ share file).
- **Import**: chọn file `.zip` để khôi phục (ghi đè dữ liệu hiện tại). Sau khi import thành công, app sẽ đóng để khởi động lại kết nối DB.

---

## 📦 Build

- Android APK (release):

```bash
fvm flutter build apk --release \
  --target-platform android-arm,android-arm64,android-x64
```

- Build tối ưu (obfuscate + split debug info):

```bash
fvm flutter build apk --release \
  --target-platform android-arm,android-arm64,android-x64 \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols
```

- iOS (macOS):

```bash
fvm flutter clean &&
fvm flutter pub get &&
cd ios && pod install && cd ..
fvm flutter build ios --release
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

- Watch i18n (slang):

```bash
dart run slang watch
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
fvm flutter install
```

Xem thêm: [COMMAND.md](COMMAND.md).

---

## 🔐 SSL Pinning

- Tạo fingerprint SHA-256 từ chứng chỉ máy chủ:

```bash
make sha256_cert url=https://api.example.com:443
```

- Thêm chuỗi SHA-256 vào biến môi trường `certificateSHA256s` rồi rebuild.

Chi tiết: [SSL_PINNING_GUIDE.md](SSL_PINNING_GUIDE.md).

---

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
