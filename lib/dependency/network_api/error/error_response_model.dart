import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response_model.freezed.dart';

part 'error_response_model.g.dart';

@freezed
abstract class ErrorResponseModel with _$ErrorResponseModel {
  const factory ErrorResponseModel({
    @JsonKey(name: 'errorCode') required int errorCode,
    @JsonKey(name: 'errorMessage') required String errorMessage,
  }) = _ErrorResponseModel;

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseModelFromJson(json);

  factory ErrorResponseModel.defaultError() => ErrorResponseModel(
        errorCode: -1,
        errorMessage: 'Có lỗi xảy ra.',
      );
}
