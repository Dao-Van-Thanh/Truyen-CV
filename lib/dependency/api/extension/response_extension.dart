import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_template/dependency/api/model/api_result.dart';
import 'package:flutter_template/dependency/network_api/error/error_response_model.dart';
import 'package:flutter_template/shared/utilities/logger.dart';

typedef FromJsonFunction<T> = T Function(Map<String, dynamic> fromJson);

extension NullableResponseExtension on Response? {
  ApiResult<T> parseData<T>(T Function(Map<String, dynamic>) fromJson) {
    try {
      if (this == null) {
        return ApiResult.error(ErrorResponseModel.defaultError());
      }

      final data = this!.data;
      if (data is Map && data['_handled'] == true) {
        return ApiResult.handled();
      }

      Map<String, dynamic> jsonData;
      if (data is Map<String, dynamic>) {
        jsonData = data;
      } else if (data is String) {
        jsonData = jsonDecode(data) as Map<String, dynamic>;
      } else {
        jsonData = {};
      }

      final isError = jsonData['success'] == 0;
      final parsed = fromJson(jsonData);
      if (isError &&
          !(jsonData['errorCode'] != 1 && jsonData['errorMessage'] == null ||
              jsonData['errorMessage'] == '')) {
        final err = ErrorResponseModel.fromJson(jsonData);
        // Trả về cả data lẫn error
        return ApiResult.error(err, data: parsed);
      }
      return ApiResult.success(parsed);
    } catch (e) {
      logger.e('Error parsing response: $e');
      return ApiResult.error(ErrorResponseModel.defaultError());
    }
  }
}
