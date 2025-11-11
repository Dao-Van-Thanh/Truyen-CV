# 🚀 Flutter Template Project

> A clean, scalable Flutter project template with BLoC pattern, Riverpod state management, and a custom routing system.

[![Flutter](https://img.shields.io/badge/Flutter-3.6.0+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.6.0+-0175C2?logo=dart)](https://dart.dev)
[![Riverpod](https://img.shields.io/badge/Riverpod-2.6.1-purple)](https://riverpod.dev)

---

## 📋 Table of Contents

- [Introduction](#-introduction)
- [Key Features](#-key-features)
- [Project Structure](#-project-structure)
- [Architecture](#-architecture)
- [Installation](#-installation)
- [Running the App](#-running-the-app)
- [Build](#-build)
- [Useful Commands](#-useful-commands)

---

## 🎯 Introduction

**Flutter Template** is a base project designed to help you quickly start Flutter projects with a clean, maintainable, and scalable architecture.

### Highlights:

- ✅ **Clean Architecture** - Clear separation between UI, Business Logic, and Data
- ✅ **BLoC Pattern** - State management with RxDart + Riverpod
- ✅ **Custom Router** - Robust routing system with auto-dispose and params handling
- ✅ **Dependency Injection** - Centralized service management via AppService
- ✅ **SSL Pinning** - Secure API connections with certificate pinning
- ✅ **Type-safe Navigation** - Navigate with type-safe arguments
- ✅ **Auto Dispose BLoC** - Automatic resource disposal

---

## ✨ Key Features

### 🧩 State Management

- **Riverpod 2.6.1** - Dependency injection and state management
- **RxDart 0.28.0** - Reactive programming with streams
- **Custom BLoC Base** - Auto-dispose and lifecycle management

### 🧭 Routing System

- **Global Navigator Key** - Navigate from anywhere (BLoC, services...)
- **Type-safe Arguments** - Params are automatically validated
- **Auto Pass to BLoC** - Route params are automatically passed to BLoC

### 🔐 Security

- **SSL Certificate Pinning** - Prevent Man-in-the-Middle attacks
- **SHA-256 Fingerprint** - Validate server certificates

### 🎨 UI/UX

- **Design System** - Constants for colors, spacing, typography
- **Responsive** - Supports multiple screen sizes
- **Material 3** - Latest Material Design guidelines

### 🔧 Developer Experience

- **Hot Reload** - Fast development with instant refresh
- **Lint Rules** - Code quality with flutter_lints
- **Extensions** - Helper methods for Ref, BuildContext

---

## 📁 Project Structure

```
lib/
├── main.dart                          # Entry point of the app
│
├── bloc/                              # BLoC Pattern Implementation
│   ├── bloc_base.dart                 # Base class for all BLoCs
│   ├── bloc_provider.dart             # Auto-dispose provider manager
│   └── rx/                            # RxDart utilities
│       ├── obs_builder.dart           # Observable builder widget
│       └── bloc_builder.dart          # BLoC builder widget
│
├── constants/                         # Design system constants
│   ├── app.dart                       # App-level constants
│   ├── colors.dart                    # Color palette
│   ├── font_sizes.dart                # Typography scale
│   ├── edge_insets.dart               # Spacing system
│   ├── corner_radius.dart             # Border radius values
│   ├── box_shadow.dart                # Shadow definitions
│   ├── gradients.dart                 # Gradient definitions
│   ├── regexs.dart                    # Validation patterns
│   └── ...
│
├── dependency/                        # Dependency Injection
│   ├── app_service.dart               # Services registry
│   ├── router/                        # Routing system
│   │   ├── router_service.dart        # Navigation service
│   │   ├── router_provider.dart       # Router implementation
│   │   ├── router_provider_interface.dart
│   │   ├── arguments/                 # Route arguments
│   │   └── utils/                     # Route utilities
│       ├── route_name.dart            # Route name constants
│       ├── route_page.dart            # Route generator
│       └── route_screen.dart          # Route builders
│   ├── api/                           # API layer
│   └── network_api/                   # Network implementation
│       └── network_api_service.dart   # HTTP client with SSL pinning
│
├── features/                          # Feature modules
│   ├── counter/                       # Counter feature example
│   │   ├── counter_screen.dart        # UI (clean, no logic)
│   │   └── counter_bloc.dart          # Business logic
│   └── unknown/                       # 404 screen
│       └── unknown_screen.dart
│
└── shared/                            # Shared utilities
    ├── extensions/                    # Dart extensions
    │   └── ref.dart                   # Ref extensions (ref.router...)
    └── env/                           # Environment config
```

---

## 🏗 Architecture

### Overall Flow:

```
UI (Screen) → BLoC (Business Logic) → Service → API/Storage
     ↑              ↓
  ObsBuilder   Subject (Stream)
```

## 🛠 Installation

### Requirements:

- Flutter SDK: **>= 3.6.0**
- Dart SDK: **>= 3.6.0**
- iOS: Xcode 15+, CocoaPods
- Android: Android Studio, JDK 11+

### Step 1: Clone the project

### Step 2: Install dependencies

```bash
flutter pub get
```

### Step 3: Generate code (if any)

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Step 4: Setup iOS (macOS only)

```bash
cd ios
pod install
cd ..
```

---

## 🚀 Running the App

### Development mode:

```bash
flutter run
```

### Choose device:

```bash
flutter devices                    # List devices
flutter run -d <device_id>         # Run on specific device
```

### Hot reload:

- Press `r` in the terminal for hot reload
- Press `R` for hot restart
- Press `q` to quit

---

## 📦 Build

### Android APK (Release):

```bash
# Build APK for all architectures
flutter build apk --release \
  --target-platform android-arm,android-arm64,android-x64

# Build with obfuscation (code protection)
flutter build apk --release \
  --target-platform android-arm,android-arm64,android-x64 \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols
```

### Android App Bundle (Google Play):

```bash
flutter build appbundle --release
```

### iOS (macOS only):

```bash
# Clean and rebuild
flutter clean && \
flutter pub get && \
cd ios && \
pod install && \
cd .. && \
flutter build ios --release
```

### Install APK to device:

```bash
flutter install
```

---

## 🔧 Useful Commands

### Format & Lint:

```bash
# Auto-fix lint issues
dart fix --apply

# Format code
dart format .

# Combine both
dart fix --apply && dart format .
```

### Clean build:

```bash
# Clean Flutter
flutter clean

# Clean build_runner
dart run build_runner clean

# Full clean (Flutter + pods)
flutter clean && cd ios && rm -rf Pods Podfile.lock && cd ..
```

### Code generation:

```bash
# Watch mode (auto rebuild on changes)
dart run build_runner watch --delete-conflicting-outputs

# One-time build
dart run build_runner build --delete-conflicting-outputs
```

### SSL Certificate Pinning:

```bash
# Generate SHA-256 fingerprint for a domain
make sha256_cert url=https://api.example.com
```

> See also: [SSL_PINNING_GUIDE.md](SSL_PINNING_GUIDE.md)

### Analyze code:

```bash
flutter analyze
```

## 📚 References

- [Flutter Documentation](https://docs.flutter.dev/)
- [Riverpod Documentation](https://riverpod.dev/)
- [RxDart Documentation](https://pub.dev/packages/rxdart)
- [SSL Pinning Guide](SSL_PINNING_GUIDE.md)
- [Commands Reference](COMMAND.md)

## 📝 License

This project is private and proprietary to GTS Vietnam.

---

## 👥 Team

**GTS Vietnam - Projects Team**

- 📧 Email: contact@gtsvn.com.vn
- 🌐 Website: [gtsvn.com.vn](https://gtsvn.com.vn)

---

## 🎉 Acknowledgments

- Flutter team for the amazing framework
- Riverpod team for powerful state management
- All contributors who helped shape this template

---

**Made with ❤️ by GTS Vietnam**
