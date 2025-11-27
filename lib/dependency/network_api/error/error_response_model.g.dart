// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ErrorResponseModel _$ErrorResponseModelFromJson(Map<String, dynamic> json) =>
    _ErrorResponseModel(
      errorCode: (json['errorCode'] as num).toInt(),
      errorMessage: json['errorMessage'] as String,
    );

Map<String, dynamic> _$ErrorResponseModelToJson(_ErrorResponseModel instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorMessage': instance.errorMessage,
    };
