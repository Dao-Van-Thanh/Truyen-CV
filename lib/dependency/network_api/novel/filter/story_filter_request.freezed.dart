// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_filter_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoryFilterRequest {
  int get status;
  int get cat;
  int get page;
  int get sort;

  /// Create a copy of StoryFilterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StoryFilterRequestCopyWith<StoryFilterRequest> get copyWith =>
      _$StoryFilterRequestCopyWithImpl<StoryFilterRequest>(
          this as StoryFilterRequest, _$identity);

  /// Serializes this StoryFilterRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StoryFilterRequest &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.cat, cat) || other.cat == cat) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.sort, sort) || other.sort == sort));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, cat, page, sort);

  @override
  String toString() {
    return 'StoryFilterRequest(status: $status, cat: $cat, page: $page, sort: $sort)';
  }
}

/// @nodoc
abstract mixin class $StoryFilterRequestCopyWith<$Res> {
  factory $StoryFilterRequestCopyWith(
          StoryFilterRequest value, $Res Function(StoryFilterRequest) _then) =
      _$StoryFilterRequestCopyWithImpl;
  @useResult
  $Res call({int status, int cat, int page, int sort});
}

/// @nodoc
class _$StoryFilterRequestCopyWithImpl<$Res>
    implements $StoryFilterRequestCopyWith<$Res> {
  _$StoryFilterRequestCopyWithImpl(this._self, this._then);

  final StoryFilterRequest _self;
  final $Res Function(StoryFilterRequest) _then;

  /// Create a copy of StoryFilterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? cat = null,
    Object? page = null,
    Object? sort = null,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      cat: null == cat
          ? _self.cat
          : cat // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      sort: null == sort
          ? _self.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _StoryFilterRequest implements StoryFilterRequest {
  const _StoryFilterRequest(
      {this.status = 0, this.cat = 0, this.page = 1, this.sort = 0});
  factory _StoryFilterRequest.fromJson(Map<String, dynamic> json) =>
      _$StoryFilterRequestFromJson(json);

  @override
  @JsonKey()
  final int status;
  @override
  @JsonKey()
  final int cat;
  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int sort;

  /// Create a copy of StoryFilterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StoryFilterRequestCopyWith<_StoryFilterRequest> get copyWith =>
      __$StoryFilterRequestCopyWithImpl<_StoryFilterRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StoryFilterRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StoryFilterRequest &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.cat, cat) || other.cat == cat) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.sort, sort) || other.sort == sort));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, cat, page, sort);

  @override
  String toString() {
    return 'StoryFilterRequest(status: $status, cat: $cat, page: $page, sort: $sort)';
  }
}

/// @nodoc
abstract mixin class _$StoryFilterRequestCopyWith<$Res>
    implements $StoryFilterRequestCopyWith<$Res> {
  factory _$StoryFilterRequestCopyWith(
          _StoryFilterRequest value, $Res Function(_StoryFilterRequest) _then) =
      __$StoryFilterRequestCopyWithImpl;
  @override
  @useResult
  $Res call({int status, int cat, int page, int sort});
}

/// @nodoc
class __$StoryFilterRequestCopyWithImpl<$Res>
    implements _$StoryFilterRequestCopyWith<$Res> {
  __$StoryFilterRequestCopyWithImpl(this._self, this._then);

  final _StoryFilterRequest _self;
  final $Res Function(_StoryFilterRequest) _then;

  /// Create a copy of StoryFilterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? cat = null,
    Object? page = null,
    Object? sort = null,
  }) {
    return _then(_StoryFilterRequest(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      cat: null == cat
          ? _self.cat
          : cat // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      sort: null == sort
          ? _self.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
