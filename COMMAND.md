## Watch for changes and rebuild

```shell
dart run build_runner watch --delete-conflicting-outputs
```

## Format & Fix lint

```shell
dart fix --apply && dart format .
```

## Clean build

```shell
dart run build_runner clean
```

## build APK

```shell
flutter build apk --release --target-platform android-arm,android-arm64,android-x64
```

## install APK

```shell
flutter install
```

## Generate environment file

```shell
dart run build_runner build --delete-conflicting-outputs
```

```shell
flutter pub run build_runner build --delete-conflicting-outputs
```

```shell
flutter pub run build_runner build
```

## Generate SHA-256 certificate fingerprint

```shell
make sha256_cert url=https://openbanking-sandbox.mbbank.com.vn:9004
```

## Build APK with obfuscation and split debug info

```shell
flutter build apk --release \
  --target-platform android-arm,android-arm64,android-x64 \
  --obfuscate \
  --split-debug-info=/TRUYENCV/lib
```

## Build iOS

```shell
flutter clean &&
flutter pub get &&
cd ios &&
pod install &&
cd ..
```

## Generate SVG icons & PNG images

```shell
npm run gen:assets
```

## Generate SHA-256 certificate fingerprint for a specific URL

```shell
make sha256_cert url=example.com:443

echo | openssl s_client -connect api.example.com:443 -servername api.example.com 2>/dev/null | openssl x509 -noout -pubkey | openssl pkey -pubin -outform der | openssl dgst -sha256 -binary | openssl base64
```

```shell
dart run slang watch
```
