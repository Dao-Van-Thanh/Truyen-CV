// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_data_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BaseDataResponseModel<T> _$BaseDataResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _BaseDataResponseModel<T>(
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$BaseDataResponseModelToJson<T>(
  _BaseDataResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
