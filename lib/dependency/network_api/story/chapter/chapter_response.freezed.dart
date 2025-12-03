// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChapterResponse {
  @JsonKey(name: 'EID')
  String? get eid;
  @JsonKey(name: 'ID')
  String? get id;
  @JsonKey(name: 'ORDER')
  String? get order;
  @JsonKey(name: 'CONTENT')
  String? get content;
  @JsonKey(name: 'NAME')
  String? get name;
  @JsonKey(name: 'ENAME')
  String? get ename;
  @JsonKey(name: 'PREV')
  String? get prev;
  @JsonKey(name: 'NEXT')
  String? get next;
  @JsonKey(name: 'UNAME')
  String? get uname;

  /// Create a copy of ChapterResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChapterResponseCopyWith<ChapterResponse> get copyWith =>
      _$ChapterResponseCopyWithImpl<ChapterResponse>(
          this as ChapterResponse, _$identity);

  /// Serializes this ChapterResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChapterResponse &&
            (identical(other.eid, eid) || other.eid == eid) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ename, ename) || other.ename == ename) &&
            (identical(other.prev, prev) || other.prev == prev) &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.uname, uname) || other.uname == uname));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, eid, id, order, content, name, ename, prev, next, uname);

  @override
  String toString() {
    return 'ChapterResponse(eid: $eid, id: $id, order: $order, content: $content, name: $name, ename: $ename, prev: $prev, next: $next, uname: $uname)';
  }
}

/// @nodoc
abstract mixin class $ChapterResponseCopyWith<$Res> {
  factory $ChapterResponseCopyWith(
          ChapterResponse value, $Res Function(ChapterResponse) _then) =
      _$ChapterResponseCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'EID') String? eid,
      @JsonKey(name: 'ID') String? id,
      @JsonKey(name: 'ORDER') String? order,
      @JsonKey(name: 'CONTENT') String? content,
      @JsonKey(name: 'NAME') String? name,
      @JsonKey(name: 'ENAME') String? ename,
      @JsonKey(name: 'PREV') String? prev,
      @JsonKey(name: 'NEXT') String? next,
      @JsonKey(name: 'UNAME') String? uname});
}

/// @nodoc
class _$ChapterResponseCopyWithImpl<$Res>
    implements $ChapterResponseCopyWith<$Res> {
  _$ChapterResponseCopyWithImpl(this._self, this._then);

  final ChapterResponse _self;
  final $Res Function(ChapterResponse) _then;

  /// Create a copy of ChapterResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eid = freezed,
    Object? id = freezed,
    Object? order = freezed,
    Object? content = freezed,
    Object? name = freezed,
    Object? ename = freezed,
    Object? prev = freezed,
    Object? next = freezed,
    Object? uname = freezed,
  }) {
    return _then(_self.copyWith(
      eid: freezed == eid
          ? _self.eid
          : eid // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      order: freezed == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      ename: freezed == ename
          ? _self.ename
          : ename // ignore: cast_nullable_to_non_nullable
              as String?,
      prev: freezed == prev
          ? _self.prev
          : prev // ignore: cast_nullable_to_non_nullable
              as String?,
      next: freezed == next
          ? _self.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      uname: freezed == uname
          ? _self.uname
          : uname // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ChapterResponse implements ChapterResponse {
  const _ChapterResponse(
      {@JsonKey(name: 'EID') this.eid,
      @JsonKey(name: 'ID') this.id,
      @JsonKey(name: 'ORDER') this.order,
      @JsonKey(name: 'CONTENT') this.content,
      @JsonKey(name: 'NAME') this.name,
      @JsonKey(name: 'ENAME') this.ename,
      @JsonKey(name: 'PREV') this.prev,
      @JsonKey(name: 'NEXT') this.next,
      @JsonKey(name: 'UNAME') this.uname});
  factory _ChapterResponse.fromJson(Map<String, dynamic> json) =>
      _$ChapterResponseFromJson(json);

  @override
  @JsonKey(name: 'EID')
  final String? eid;
  @override
  @JsonKey(name: 'ID')
  final String? id;
  @override
  @JsonKey(name: 'ORDER')
  final String? order;
  @override
  @JsonKey(name: 'CONTENT')
  final String? content;
  @override
  @JsonKey(name: 'NAME')
  final String? name;
  @override
  @JsonKey(name: 'ENAME')
  final String? ename;
  @override
  @JsonKey(name: 'PREV')
  final String? prev;
  @override
  @JsonKey(name: 'NEXT')
  final String? next;
  @override
  @JsonKey(name: 'UNAME')
  final String? uname;

  /// Create a copy of ChapterResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChapterResponseCopyWith<_ChapterResponse> get copyWith =>
      __$ChapterResponseCopyWithImpl<_ChapterResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChapterResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChapterResponse &&
            (identical(other.eid, eid) || other.eid == eid) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ename, ename) || other.ename == ename) &&
            (identical(other.prev, prev) || other.prev == prev) &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.uname, uname) || other.uname == uname));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, eid, id, order, content, name, ename, prev, next, uname);

  @override
  String toString() {
    return 'ChapterResponse(eid: $eid, id: $id, order: $order, content: $content, name: $name, ename: $ename, prev: $prev, next: $next, uname: $uname)';
  }
}

/// @nodoc
abstract mixin class _$ChapterResponseCopyWith<$Res>
    implements $ChapterResponseCopyWith<$Res> {
  factory _$ChapterResponseCopyWith(
          _ChapterResponse value, $Res Function(_ChapterResponse) _then) =
      __$ChapterResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'EID') String? eid,
      @JsonKey(name: 'ID') String? id,
      @JsonKey(name: 'ORDER') String? order,
      @JsonKey(name: 'CONTENT') String? content,
      @JsonKey(name: 'NAME') String? name,
      @JsonKey(name: 'ENAME') String? ename,
      @JsonKey(name: 'PREV') String? prev,
      @JsonKey(name: 'NEXT') String? next,
      @JsonKey(name: 'UNAME') String? uname});
}

/// @nodoc
class __$ChapterResponseCopyWithImpl<$Res>
    implements _$ChapterResponseCopyWith<$Res> {
  __$ChapterResponseCopyWithImpl(this._self, this._then);

  final _ChapterResponse _self;
  final $Res Function(_ChapterResponse) _then;

  /// Create a copy of ChapterResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? eid = freezed,
    Object? id = freezed,
    Object? order = freezed,
    Object? content = freezed,
    Object? name = freezed,
    Object? ename = freezed,
    Object? prev = freezed,
    Object? next = freezed,
    Object? uname = freezed,
  }) {
    return _then(_ChapterResponse(
      eid: freezed == eid
          ? _self.eid
          : eid // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      order: freezed == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      ename: freezed == ename
          ? _self.ename
          : ename // ignore: cast_nullable_to_non_nullable
              as String?,
      prev: freezed == prev
          ? _self.prev
          : prev // ignore: cast_nullable_to_non_nullable
              as String?,
      next: freezed == next
          ? _self.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      uname: freezed == uname
          ? _self.uname
          : uname // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
