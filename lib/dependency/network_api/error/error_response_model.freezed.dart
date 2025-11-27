// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ErrorResponseModel {
  @JsonKey(name: 'errorCode')
  int get errorCode;
  @JsonKey(name: 'errorMessage')
  String get errorMessage;

  /// Create a copy of ErrorResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ErrorResponseModelCopyWith<ErrorResponseModel> get copyWith =>
      _$ErrorResponseModelCopyWithImpl<ErrorResponseModel>(
          this as ErrorResponseModel, _$identity);

  /// Serializes this ErrorResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ErrorResponseModel &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, errorCode, errorMessage);

  @override
  String toString() {
    return 'ErrorResponseModel(errorCode: $errorCode, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $ErrorResponseModelCopyWith<$Res> {
  factory $ErrorResponseModelCopyWith(
          ErrorResponseModel value, $Res Function(ErrorResponseModel) _then) =
      _$ErrorResponseModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'errorCode') int errorCode,
      @JsonKey(name: 'errorMessage') String errorMessage});
}

/// @nodoc
class _$ErrorResponseModelCopyWithImpl<$Res>
    implements $ErrorResponseModelCopyWith<$Res> {
  _$ErrorResponseModelCopyWithImpl(this._self, this._then);

  final ErrorResponseModel _self;
  final $Res Function(ErrorResponseModel) _then;

  /// Create a copy of ErrorResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorCode = null,
    Object? errorMessage = null,
  }) {
    return _then(_self.copyWith(
      errorCode: null == errorCode
          ? _self.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ErrorResponseModel implements ErrorResponseModel {
  const _ErrorResponseModel(
      {@JsonKey(name: 'errorCode') required this.errorCode,
      @JsonKey(name: 'errorMessage') required this.errorMessage});
  factory _ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseModelFromJson(json);

  @override
  @JsonKey(name: 'errorCode')
  final int errorCode;
  @override
  @JsonKey(name: 'errorMessage')
  final String errorMessage;

  /// Create a copy of ErrorResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ErrorResponseModelCopyWith<_ErrorResponseModel> get copyWith =>
      __$ErrorResponseModelCopyWithImpl<_ErrorResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ErrorResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ErrorResponseModel &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, errorCode, errorMessage);

  @override
  String toString() {
    return 'ErrorResponseModel(errorCode: $errorCode, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$ErrorResponseModelCopyWith<$Res>
    implements $ErrorResponseModelCopyWith<$Res> {
  factory _$ErrorResponseModelCopyWith(
          _ErrorResponseModel value, $Res Function(_ErrorResponseModel) _then) =
      __$ErrorResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'errorCode') int errorCode,
      @JsonKey(name: 'errorMessage') String errorMessage});
}

/// @nodoc
class __$ErrorResponseModelCopyWithImpl<$Res>
    implements _$ErrorResponseModelCopyWith<$Res> {
  __$ErrorResponseModelCopyWithImpl(this._self, this._then);

  final _ErrorResponseModel _self;
  final $Res Function(_ErrorResponseModel) _then;

  /// Create a copy of ErrorResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? errorCode = null,
    Object? errorMessage = null,
  }) {
    return _then(_ErrorResponseModel(
      errorCode: null == errorCode
          ? _self.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
