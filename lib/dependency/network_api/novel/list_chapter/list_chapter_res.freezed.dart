// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_chapter_res.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListChapterRes {
  @JsonKey(name: 'ID')
  String? get id;
  @JsonKey(name: 'ORDER')
  String? get order;
  @JsonKey(name: 'NAME')
  String? get name;
  @JsonKey(name: 'URL')
  String? get url;
  @JsonKey(name: 'USER')
  String? get user;
  @JsonKey(name: 'USERURL')
  String? get userUrl;
  @JsonKey(name: 'DATE')
  String? get date;
  @JsonKey(name: 'COUNT')
  int? get count;

  /// Create a copy of ListChapterRes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ListChapterResCopyWith<ListChapterRes> get copyWith =>
      _$ListChapterResCopyWithImpl<ListChapterRes>(
          this as ListChapterRes, _$identity);

  /// Serializes this ListChapterRes to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ListChapterRes &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.userUrl, userUrl) || other.userUrl == userUrl) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, order, name, url, user, userUrl, date, count);

  @override
  String toString() {
    return 'ListChapterRes(id: $id, order: $order, name: $name, url: $url, user: $user, userUrl: $userUrl, date: $date, count: $count)';
  }
}

/// @nodoc
abstract mixin class $ListChapterResCopyWith<$Res> {
  factory $ListChapterResCopyWith(
          ListChapterRes value, $Res Function(ListChapterRes) _then) =
      _$ListChapterResCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'ID') String? id,
      @JsonKey(name: 'ORDER') String? order,
      @JsonKey(name: 'NAME') String? name,
      @JsonKey(name: 'URL') String? url,
      @JsonKey(name: 'USER') String? user,
      @JsonKey(name: 'USERURL') String? userUrl,
      @JsonKey(name: 'DATE') String? date,
      @JsonKey(name: 'COUNT') int? count});
}

/// @nodoc
class _$ListChapterResCopyWithImpl<$Res>
    implements $ListChapterResCopyWith<$Res> {
  _$ListChapterResCopyWithImpl(this._self, this._then);

  final ListChapterRes _self;
  final $Res Function(ListChapterRes) _then;

  /// Create a copy of ListChapterRes
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? order = freezed,
    Object? name = freezed,
    Object? url = freezed,
    Object? user = freezed,
    Object? userUrl = freezed,
    Object? date = freezed,
    Object? count = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      order: freezed == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      userUrl: freezed == userUrl
          ? _self.userUrl
          : userUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      count: freezed == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ListChapterRes implements ListChapterRes {
  const _ListChapterRes(
      {@JsonKey(name: 'ID') this.id,
      @JsonKey(name: 'ORDER') this.order,
      @JsonKey(name: 'NAME') this.name,
      @JsonKey(name: 'URL') this.url,
      @JsonKey(name: 'USER') this.user,
      @JsonKey(name: 'USERURL') this.userUrl,
      @JsonKey(name: 'DATE') this.date,
      @JsonKey(name: 'COUNT') this.count});
  factory _ListChapterRes.fromJson(Map<String, dynamic> json) =>
      _$ListChapterResFromJson(json);

  @override
  @JsonKey(name: 'ID')
  final String? id;
  @override
  @JsonKey(name: 'ORDER')
  final String? order;
  @override
  @JsonKey(name: 'NAME')
  final String? name;
  @override
  @JsonKey(name: 'URL')
  final String? url;
  @override
  @JsonKey(name: 'USER')
  final String? user;
  @override
  @JsonKey(name: 'USERURL')
  final String? userUrl;
  @override
  @JsonKey(name: 'DATE')
  final String? date;
  @override
  @JsonKey(name: 'COUNT')
  final int? count;

  /// Create a copy of ListChapterRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ListChapterResCopyWith<_ListChapterRes> get copyWith =>
      __$ListChapterResCopyWithImpl<_ListChapterRes>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ListChapterResToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ListChapterRes &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.userUrl, userUrl) || other.userUrl == userUrl) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, order, name, url, user, userUrl, date, count);

  @override
  String toString() {
    return 'ListChapterRes(id: $id, order: $order, name: $name, url: $url, user: $user, userUrl: $userUrl, date: $date, count: $count)';
  }
}

/// @nodoc
abstract mixin class _$ListChapterResCopyWith<$Res>
    implements $ListChapterResCopyWith<$Res> {
  factory _$ListChapterResCopyWith(
          _ListChapterRes value, $Res Function(_ListChapterRes) _then) =
      __$ListChapterResCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'ID') String? id,
      @JsonKey(name: 'ORDER') String? order,
      @JsonKey(name: 'NAME') String? name,
      @JsonKey(name: 'URL') String? url,
      @JsonKey(name: 'USER') String? user,
      @JsonKey(name: 'USERURL') String? userUrl,
      @JsonKey(name: 'DATE') String? date,
      @JsonKey(name: 'COUNT') int? count});
}

/// @nodoc
class __$ListChapterResCopyWithImpl<$Res>
    implements _$ListChapterResCopyWith<$Res> {
  __$ListChapterResCopyWithImpl(this._self, this._then);

  final _ListChapterRes _self;
  final $Res Function(_ListChapterRes) _then;

  /// Create a copy of ListChapterRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? order = freezed,
    Object? name = freezed,
    Object? url = freezed,
    Object? user = freezed,
    Object? userUrl = freezed,
    Object? date = freezed,
    Object? count = freezed,
  }) {
    return _then(_ListChapterRes(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      order: freezed == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      userUrl: freezed == userUrl
          ? _self.userUrl
          : userUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      count: freezed == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
