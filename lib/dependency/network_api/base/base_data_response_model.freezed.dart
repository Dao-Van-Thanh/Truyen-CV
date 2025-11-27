// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_data_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BaseDataResponseModel<T> {
  T? get data;

  /// Create a copy of BaseDataResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BaseDataResponseModelCopyWith<T, BaseDataResponseModel<T>> get copyWith =>
      _$BaseDataResponseModelCopyWithImpl<T, BaseDataResponseModel<T>>(
          this as BaseDataResponseModel<T>, _$identity);

  /// Serializes this BaseDataResponseModel to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BaseDataResponseModel<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @override
  String toString() {
    return 'BaseDataResponseModel<$T>(data: $data)';
  }
}

/// @nodoc
abstract mixin class $BaseDataResponseModelCopyWith<T, $Res> {
  factory $BaseDataResponseModelCopyWith(BaseDataResponseModel<T> value,
          $Res Function(BaseDataResponseModel<T>) _then) =
      _$BaseDataResponseModelCopyWithImpl;
  @useResult
  $Res call({T? data});
}

/// @nodoc
class _$BaseDataResponseModelCopyWithImpl<T, $Res>
    implements $BaseDataResponseModelCopyWith<T, $Res> {
  _$BaseDataResponseModelCopyWithImpl(this._self, this._then);

  final BaseDataResponseModel<T> _self;
  final $Res Function(BaseDataResponseModel<T>) _then;

  /// Create a copy of BaseDataResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_self.copyWith(
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _BaseDataResponseModel<T> implements BaseDataResponseModel<T> {
  const _BaseDataResponseModel({this.data});
  factory _BaseDataResponseModel.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$BaseDataResponseModelFromJson(json, fromJsonT);

  @override
  final T? data;

  /// Create a copy of BaseDataResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BaseDataResponseModelCopyWith<T, _BaseDataResponseModel<T>> get copyWith =>
      __$BaseDataResponseModelCopyWithImpl<T, _BaseDataResponseModel<T>>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$BaseDataResponseModelToJson<T>(this, toJsonT);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BaseDataResponseModel<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @override
  String toString() {
    return 'BaseDataResponseModel<$T>(data: $data)';
  }
}

/// @nodoc
abstract mixin class _$BaseDataResponseModelCopyWith<T, $Res>
    implements $BaseDataResponseModelCopyWith<T, $Res> {
  factory _$BaseDataResponseModelCopyWith(_BaseDataResponseModel<T> value,
          $Res Function(_BaseDataResponseModel<T>) _then) =
      __$BaseDataResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call({T? data});
}

/// @nodoc
class __$BaseDataResponseModelCopyWithImpl<T, $Res>
    implements _$BaseDataResponseModelCopyWith<T, $Res> {
  __$BaseDataResponseModelCopyWithImpl(this._self, this._then);

  final _BaseDataResponseModel<T> _self;
  final $Res Function(_BaseDataResponseModel<T>) _then;

  /// Create a copy of BaseDataResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_BaseDataResponseModel<T>(
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

// dart format on
