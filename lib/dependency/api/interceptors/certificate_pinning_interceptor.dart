import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';

class CustomCertificatePinningInterceptor
    extends CertificatePinningInterceptor {
  CustomCertificatePinningInterceptor({
    required List<String> allowedSHAFingerprints,
  }) : super(
          allowedSHAFingerprints: allowedSHAFingerprints,
          callFollowingErrorInterceptor: true,
        );

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.error is CertificateNotVerifiedException) {
      debugPrint('Certificate pinning error: ${err.error}');
    }
    super.onError(err, handler);
  }
}
