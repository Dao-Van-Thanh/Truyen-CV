import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/shared/env/env_model.dart';

typedef CacheKey = Object;

class ApiService {
  final Ref ref;
  static const _timeout = CommonConstants.apiTimeout;
  late final Dio dio;
  late final routerService = ref.read(AppService.router);
  late final DefaultCacheManager cacheManager = DefaultCacheManager();
  CancelableOperation<Response?>? _currentOperation;

  ApiService(this.ref) {
    dio = Dio(
      BaseOptions(
        baseUrl: envVars.baseUrl,
        connectTimeout: _timeout,
        receiveTimeout: _timeout,
        sendTimeout: _timeout,
        // validateStatus: (status) {
        //   if (status == 401) return false;
        //   return true;
        // },
      ),
    );
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
      return client;
    };
  }

  void addInterceptors(List<Interceptor> interceptors) {
    dio.interceptors.addAll(interceptors);
  }

  Future<Response?> _request<T>(
    Future<Response<T>> Function(CancelToken) request, {
    String? path,
  }) async {
    final cancelToken = CancelToken();
    final operation = CancelableOperation.fromFuture(
      Future(() async {
        try {
          final response = await request(cancelToken);
          return response;
        } catch (e) {
          return null;
        }
      }),
      onCancel: () {
        cancelToken.cancel('Request canceled');
        return (null, 'Canceled');
      },
    );
    _currentOperation = operation; // Lưu để hủy trong _handleLogout
    return operation.value;
  }

  Future<Response?> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? key,
    bool shouldCache = false,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    if (shouldCache) {
      final cachedResponse = await _getCachedResponse(
        key: key,
        path: path,
        queryParameters: queryParameters,
      );
      if (cachedResponse != null) return cachedResponse;
    }

    final result = await _request(
      (cancelT) => dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken ?? cancelT,
        onReceiveProgress: onReceiveProgress,
      ),
      path: path,
    );

    final res = result;

    if (shouldCache && res != null) {
      await _cacheResponse(
        path,
        res,
        queryParameters: queryParameters,
        key: key,
      );
    }
    return result;
  }

  Future<Response?> post(
    String path, {
    Object? data,
    String? key,
    Options? options,
    bool shouldCache = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    if (shouldCache) {
      final cachedResponse = await _getCachedResponse(
        key: key,
        path: path,
        data: data,
        queryParameters: queryParameters,
      );
      if (cachedResponse != null) return cachedResponse;
    }

    final result = await _request(
      (cancelToken) => dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
      ),
      path: path,
    );

    final res = result;

    if (shouldCache && res != null) {
      await _cacheResponse(
        path,
        res,
        data: data,
        queryParameters: queryParameters,
        key: key,
      );
    }
    return result;
  }

  Future<Response?> put(
    String path, {
    Object? data,
    String? key,
    bool shouldCache = false,
  }) async {
    if (shouldCache) {
      final cachedResponse = await _getCachedResponse(
        key: key,
        path: path,
        data: data,
      );
      if (cachedResponse != null) return cachedResponse;
    }

    final result = await _request(
      (cancelToken) => dio.put(
        path,
        data: data,
        cancelToken: cancelToken,
      ),
      path: path,
    );
    final res = result;

    if (shouldCache && res != null) {
      await _cacheResponse(
        path,
        res,
        data: data,
        key: key,
      );
    }
    return result;
  }

  Future<Response?> delete(
    String path, {
    Object? data,
    String? key,
    bool shouldCache = false,
  }) async {
    if (shouldCache) {
      final cachedResponse = await _getCachedResponse(
        key: key,
        path: path,
        data: data,
      );
      if (cachedResponse != null) return cachedResponse;
    }

    final result = await _request(
      (cancelToken) => dio.delete(
        path,
        data: data,
        cancelToken: cancelToken,
      ),
      path: path,
    );
    final res = result;

    if (shouldCache && res != null) {
      await _cacheResponse(
        path,
        res,
        data: data,
        key: key,
      );
    }
    return result;
  }

  Future<Response?> _getCachedResponse({
    String? key,
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final cacheKey = _hashCacheKey([key ?? path, data, queryParameters]);
    final fileInfo = await cacheManager.getFileFromCache(cacheKey);
    if (fileInfo != null && fileInfo.validTill.isAfter(DateTime.now())) {
      final jsonData = jsonDecode(await fileInfo.file.readAsString());
      return Response(
        data: jsonData['data'],
        requestOptions: RequestOptions(path: path),
        statusCode: 200,
      );
    }
    return null;
  }

  Future<void> _cacheResponse(
    String path,
    Response response, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    String? key,
    Duration maxAge = const Duration(minutes: 10),
  }) async {
    final cacheKey = _hashCacheKey([key ?? path, data, queryParameters]);
    final cacheData = {
      'data': response.data,
      'lastFetched': DateTime.now().toIso8601String(),
    };
    await cacheManager.putFile(
      cacheKey,
      utf8.encode(jsonEncode(cacheData)),
      maxAge: maxAge,
    );
  }

  // Response? _handleError(dynamic error, String path) {
  //   return null;
  //   // if (error is! DioException) {
  //   //   return _handledResponse(path);
  //   // }

  //   // // final response = error.response;
  //   // // final statusCode = response?.statusCode;

  //   // return response ?? _handledResponse(path);
  // }

  // Response _handledResponse(String path) {
  //   return Response(
  //     data: {'_handled': true},
  //     requestOptions: RequestOptions(path: path),
  //   );
  // }

  String _hashCacheKey(CacheKey key) {
    if (key is String) return key;
    return json.encode(key);
  }

  void invalidateCache({CacheKey? cacheKey}) {
    if (cacheKey == null) {
      cacheManager.emptyCache();
    } else {
      cacheManager.removeFile(_hashCacheKey(cacheKey));
    }
  }

  void cancelApi() {
    _currentOperation?.cancel();
  }

  Future<Response?> download(
    String path,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _request(
      (cancelToken) => dio.download(
        path,
        savePath,
        queryParameters: queryParameters,
        options: options,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      ),
      path: path,
    );
  }
}
