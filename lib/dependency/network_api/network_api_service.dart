import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/dependency/api/api_service.dart';
import 'package:flutter_template/dependency/api/interceptors/certificate_pinning_interceptor.dart';
import 'package:flutter_template/dependency/network_api/story/story_repository.dart';
import 'package:flutter_template/shared/env/env_model.dart';

void _addSSLPinningInterceptor(ApiService apiService) {
  if (kDebugMode) return;

  apiService.addInterceptors([
    CustomCertificatePinningInterceptor(
      allowedSHAFingerprints: envVars.certificateSHA256s,
    ),
  ]);
}

final _apiProvider = Provider((ref) {
  final apiService = ApiService(ref);
  // _addSSLPinningInterceptor(apiService); // http no SSL pinning
  return apiService;
});

class NetworkApiService {
  final Ref ref;

  NetworkApiService(this.ref);

  void get clearCache {
    _apiService.invalidateCache();
  }

  late final _apiService = ref.watch(_apiProvider);

  late final storyRepository = StoryRepository(_apiService);
}
