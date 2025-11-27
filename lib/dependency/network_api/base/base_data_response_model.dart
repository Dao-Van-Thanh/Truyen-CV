import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_data_response_model.freezed.dart';
part 'base_data_response_model.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class BaseDataResponseModel<T> with _$BaseDataResponseModel<T> {
  const factory BaseDataResponseModel({
    T? data,
  }) = _BaseDataResponseModel<T>;

  factory BaseDataResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$BaseDataResponseModelFromJson(json, fromJsonT);
}
