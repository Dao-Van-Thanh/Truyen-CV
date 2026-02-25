import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/dependency/api/api_service.dart';
import 'package:flutter_template/dependency/api/interceptors/certificate_pinning_interceptor.dart';
import 'package:flutter_template/dependency/network_api/comic/comic_repository.dart';
import 'package:flutter_template/dependency/network_api/novel/novel_repository.dart';
import 'package:flutter_template/shared/env/env_model.dart';
import 'package:flutter_template/shared/utilities/logger.dart';

void _addSSLPinningInterceptor(
  ApiService apiService, {
  required List<String> allowedSHAFingerprints,
}) {
  if (kDebugMode) return;

  apiService.addInterceptors([
    CustomCertificatePinningInterceptor(
      allowedSHAFingerprints: allowedSHAFingerprints,
    ),
  ]);
}

final _apiNovelProvider = Provider((ref) {
  final baseUrl = envVars.novelUrl;
  final apiService = ApiService(ref, baseUrl: baseUrl);
  // _addSSLPinningInterceptor(apiService, allowedSHAFingerprints: []); // http no SSL pinning
  return apiService;
});

final _apiComicProvider = Provider((ref) {
  final baseUrl = envVars.comicUrl;
  final certificateSHA256s = envVars.certificatePins['comicUrl'] ?? [];
  if (certificateSHA256s.isEmpty) {
    logger.e('certificateSHA256s is empty');
  }
  final apiService = ApiService(ref, baseUrl: baseUrl);
  _addSSLPinningInterceptor(
    apiService,
    allowedSHAFingerprints: certificateSHA256s,
  ); // http no SSL pinning
});

class NetworkApiService {
  final Ref ref;

  NetworkApiService(this.ref);

  void get clearCache {
    _apiNovelService.invalidateCache();
  }

  late final _apiNovelService = ref.watch(_apiNovelProvider);
  late final _apiComicService = ref.watch(_apiComicProvider);

  late final novelRepository = NovelRepository(_apiNovelService);
  late final comicRepository = ComicRepository(_apiComicService);
}
