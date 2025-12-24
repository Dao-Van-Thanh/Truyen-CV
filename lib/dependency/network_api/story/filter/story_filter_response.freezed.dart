// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_filter_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoryFilterResponse {
  int? get success;
  PagerModel? get pager;
  @JsonKey(fromJson: _convertListDynamic)
  List<StoryModel>? get data;

  /// Create a copy of StoryFilterResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StoryFilterResponseCopyWith<StoryFilterResponse> get copyWith =>
      _$StoryFilterResponseCopyWithImpl<StoryFilterResponse>(
          this as StoryFilterResponse, _$identity);

  /// Serializes this StoryFilterResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StoryFilterResponse &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.pager, pager) || other.pager == pager) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, success, pager, const DeepCollectionEquality().hash(data));

  @override
  String toString() {
    return 'StoryFilterResponse(success: $success, pager: $pager, data: $data)';
  }
}

/// @nodoc
abstract mixin class $StoryFilterResponseCopyWith<$Res> {
  factory $StoryFilterResponseCopyWith(
          StoryFilterResponse value, $Res Function(StoryFilterResponse) _then) =
      _$StoryFilterResponseCopyWithImpl;
  @useResult
  $Res call(
      {int? success,
      PagerModel? pager,
      @JsonKey(fromJson: _convertListDynamic) List<StoryModel>? data});

  $PagerModelCopyWith<$Res>? get pager;
}

/// @nodoc
class _$StoryFilterResponseCopyWithImpl<$Res>
    implements $StoryFilterResponseCopyWith<$Res> {
  _$StoryFilterResponseCopyWithImpl(this._self, this._then);

  final StoryFilterResponse _self;
  final $Res Function(StoryFilterResponse) _then;

  /// Create a copy of StoryFilterResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = freezed,
    Object? pager = freezed,
    Object? data = freezed,
  }) {
    return _then(_self.copyWith(
      success: freezed == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as int?,
      pager: freezed == pager
          ? _self.pager
          : pager // ignore: cast_nullable_to_non_nullable
              as PagerModel?,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<StoryModel>?,
    ));
  }

  /// Create a copy of StoryFilterResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PagerModelCopyWith<$Res>? get pager {
    if (_self.pager == null) {
      return null;
    }

    return $PagerModelCopyWith<$Res>(_self.pager!, (value) {
      return _then(_self.copyWith(pager: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _StoryFilterResponse implements StoryFilterResponse {
  const _StoryFilterResponse(
      {this.success,
      this.pager,
      @JsonKey(fromJson: _convertListDynamic) final List<StoryModel>? data})
      : _data = data;
  factory _StoryFilterResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryFilterResponseFromJson(json);

  @override
  final int? success;
  @override
  final PagerModel? pager;
  final List<StoryModel>? _data;
  @override
  @JsonKey(fromJson: _convertListDynamic)
  List<StoryModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of StoryFilterResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StoryFilterResponseCopyWith<_StoryFilterResponse> get copyWith =>
      __$StoryFilterResponseCopyWithImpl<_StoryFilterResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StoryFilterResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StoryFilterResponse &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.pager, pager) || other.pager == pager) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, success, pager, const DeepCollectionEquality().hash(_data));

  @override
  String toString() {
    return 'StoryFilterResponse(success: $success, pager: $pager, data: $data)';
  }
}

/// @nodoc
abstract mixin class _$StoryFilterResponseCopyWith<$Res>
    implements $StoryFilterResponseCopyWith<$Res> {
  factory _$StoryFilterResponseCopyWith(_StoryFilterResponse value,
          $Res Function(_StoryFilterResponse) _then) =
      __$StoryFilterResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? success,
      PagerModel? pager,
      @JsonKey(fromJson: _convertListDynamic) List<StoryModel>? data});

  @override
  $PagerModelCopyWith<$Res>? get pager;
}

/// @nodoc
class __$StoryFilterResponseCopyWithImpl<$Res>
    implements _$StoryFilterResponseCopyWith<$Res> {
  __$StoryFilterResponseCopyWithImpl(this._self, this._then);

  final _StoryFilterResponse _self;
  final $Res Function(_StoryFilterResponse) _then;

  /// Create a copy of StoryFilterResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? success = freezed,
    Object? pager = freezed,
    Object? data = freezed,
  }) {
    return _then(_StoryFilterResponse(
      success: freezed == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as int?,
      pager: freezed == pager
          ? _self.pager
          : pager // ignore: cast_nullable_to_non_nullable
              as PagerModel?,
      data: freezed == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<StoryModel>?,
    ));
  }

  /// Create a copy of StoryFilterResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PagerModelCopyWith<$Res>? get pager {
    if (_self.pager == null) {
      return null;
    }

    return $PagerModelCopyWith<$Res>(_self.pager!, (value) {
      return _then(_self.copyWith(pager: value));
    });
  }
}

/// @nodoc
mixin _$PagerModel {
  int? get page;
  @JsonKey(fromJson: _convertSize)
  int? get size;
  @JsonKey(name: 'total_count')
  String? get totalCount;

  /// Create a copy of PagerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PagerModelCopyWith<PagerModel> get copyWith =>
      _$PagerModelCopyWithImpl<PagerModel>(this as PagerModel, _$identity);

  /// Serializes this PagerModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PagerModel &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, page, size, totalCount);

  @override
  String toString() {
    return 'PagerModel(page: $page, size: $size, totalCount: $totalCount)';
  }
}

/// @nodoc
abstract mixin class $PagerModelCopyWith<$Res> {
  factory $PagerModelCopyWith(
          PagerModel value, $Res Function(PagerModel) _then) =
      _$PagerModelCopyWithImpl;
  @useResult
  $Res call(
      {int? page,
      @JsonKey(fromJson: _convertSize) int? size,
      @JsonKey(name: 'total_count') String? totalCount});
}

/// @nodoc
class _$PagerModelCopyWithImpl<$Res> implements $PagerModelCopyWith<$Res> {
  _$PagerModelCopyWithImpl(this._self, this._then);

  final PagerModel _self;
  final $Res Function(PagerModel) _then;

  /// Create a copy of PagerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? size = freezed,
    Object? totalCount = freezed,
  }) {
    return _then(_self.copyWith(
      page: freezed == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      size: freezed == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
      totalCount: freezed == totalCount
          ? _self.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PagerModel implements PagerModel {
  const _PagerModel(
      {this.page,
      @JsonKey(fromJson: _convertSize) this.size,
      @JsonKey(name: 'total_count') this.totalCount});
  factory _PagerModel.fromJson(Map<String, dynamic> json) =>
      _$PagerModelFromJson(json);

  @override
  final int? page;
  @override
  @JsonKey(fromJson: _convertSize)
  final int? size;
  @override
  @JsonKey(name: 'total_count')
  final String? totalCount;

  /// Create a copy of PagerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PagerModelCopyWith<_PagerModel> get copyWith =>
      __$PagerModelCopyWithImpl<_PagerModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PagerModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PagerModel &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, page, size, totalCount);

  @override
  String toString() {
    return 'PagerModel(page: $page, size: $size, totalCount: $totalCount)';
  }
}

/// @nodoc
abstract mixin class _$PagerModelCopyWith<$Res>
    implements $PagerModelCopyWith<$Res> {
  factory _$PagerModelCopyWith(
          _PagerModel value, $Res Function(_PagerModel) _then) =
      __$PagerModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? page,
      @JsonKey(fromJson: _convertSize) int? size,
      @JsonKey(name: 'total_count') String? totalCount});
}

/// @nodoc
class __$PagerModelCopyWithImpl<$Res> implements _$PagerModelCopyWith<$Res> {
  __$PagerModelCopyWithImpl(this._self, this._then);

  final _PagerModel _self;
  final $Res Function(_PagerModel) _then;

  /// Create a copy of PagerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? page = freezed,
    Object? size = freezed,
    Object? totalCount = freezed,
  }) {
    return _then(_PagerModel(
      page: freezed == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      size: freezed == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
      totalCount: freezed == totalCount
          ? _self.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$StoryModel {
  @JsonKey(name: 'ID')
  String? get id;
  @JsonKey(name: 'NAME')
  String? get name;
  @JsonKey(name: 'THUMB')
  String? get thumb;
  @JsonKey(name: 'PROCESS')
  String? get process;
  @JsonKey(name: 'AUTHOR')
  String? get author;
  @JsonKey(name: 'VIEWED')
  String? get viewed;
  @JsonKey(name: 'RATING')
  double? get rating;
  @JsonKey(name: 'COUNT')
  int? get count;

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StoryModelCopyWith<StoryModel> get copyWith =>
      _$StoryModelCopyWithImpl<StoryModel>(this as StoryModel, _$identity);

  /// Serializes this StoryModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StoryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.thumb, thumb) || other.thumb == thumb) &&
            (identical(other.process, process) || other.process == process) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.viewed, viewed) || other.viewed == viewed) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, thumb, process, author, viewed, rating, count);

  @override
  String toString() {
    return 'StoryModel(id: $id, name: $name, thumb: $thumb, process: $process, author: $author, viewed: $viewed, rating: $rating, count: $count)';
  }
}

/// @nodoc
abstract mixin class $StoryModelCopyWith<$Res> {
  factory $StoryModelCopyWith(
          StoryModel value, $Res Function(StoryModel) _then) =
      _$StoryModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'ID') String? id,
      @JsonKey(name: 'NAME') String? name,
      @JsonKey(name: 'THUMB') String? thumb,
      @JsonKey(name: 'PROCESS') String? process,
      @JsonKey(name: 'AUTHOR') String? author,
      @JsonKey(name: 'VIEWED') String? viewed,
      @JsonKey(name: 'RATING') double? rating,
      @JsonKey(name: 'COUNT') int? count});
}

/// @nodoc
class _$StoryModelCopyWithImpl<$Res> implements $StoryModelCopyWith<$Res> {
  _$StoryModelCopyWithImpl(this._self, this._then);

  final StoryModel _self;
  final $Res Function(StoryModel) _then;

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? thumb = freezed,
    Object? process = freezed,
    Object? author = freezed,
    Object? viewed = freezed,
    Object? rating = freezed,
    Object? count = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      thumb: freezed == thumb
          ? _self.thumb
          : thumb // ignore: cast_nullable_to_non_nullable
              as String?,
      process: freezed == process
          ? _self.process
          : process // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      viewed: freezed == viewed
          ? _self.viewed
          : viewed // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      count: freezed == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _StoryModel implements StoryModel {
  const _StoryModel(
      {@JsonKey(name: 'ID') this.id,
      @JsonKey(name: 'NAME') this.name,
      @JsonKey(name: 'THUMB') this.thumb,
      @JsonKey(name: 'PROCESS') this.process,
      @JsonKey(name: 'AUTHOR') this.author,
      @JsonKey(name: 'VIEWED') this.viewed,
      @JsonKey(name: 'RATING') this.rating,
      @JsonKey(name: 'COUNT') this.count});
  factory _StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);

  @override
  @JsonKey(name: 'ID')
  final String? id;
  @override
  @JsonKey(name: 'NAME')
  final String? name;
  @override
  @JsonKey(name: 'THUMB')
  final String? thumb;
  @override
  @JsonKey(name: 'PROCESS')
  final String? process;
  @override
  @JsonKey(name: 'AUTHOR')
  final String? author;
  @override
  @JsonKey(name: 'VIEWED')
  final String? viewed;
  @override
  @JsonKey(name: 'RATING')
  final double? rating;
  @override
  @JsonKey(name: 'COUNT')
  final int? count;

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StoryModelCopyWith<_StoryModel> get copyWith =>
      __$StoryModelCopyWithImpl<_StoryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StoryModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StoryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.thumb, thumb) || other.thumb == thumb) &&
            (identical(other.process, process) || other.process == process) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.viewed, viewed) || other.viewed == viewed) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, thumb, process, author, viewed, rating, count);

  @override
  String toString() {
    return 'StoryModel(id: $id, name: $name, thumb: $thumb, process: $process, author: $author, viewed: $viewed, rating: $rating, count: $count)';
  }
}

/// @nodoc
abstract mixin class _$StoryModelCopyWith<$Res>
    implements $StoryModelCopyWith<$Res> {
  factory _$StoryModelCopyWith(
          _StoryModel value, $Res Function(_StoryModel) _then) =
      __$StoryModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'ID') String? id,
      @JsonKey(name: 'NAME') String? name,
      @JsonKey(name: 'THUMB') String? thumb,
      @JsonKey(name: 'PROCESS') String? process,
      @JsonKey(name: 'AUTHOR') String? author,
      @JsonKey(name: 'VIEWED') String? viewed,
      @JsonKey(name: 'RATING') double? rating,
      @JsonKey(name: 'COUNT') int? count});
}

/// @nodoc
class __$StoryModelCopyWithImpl<$Res> implements _$StoryModelCopyWith<$Res> {
  __$StoryModelCopyWithImpl(this._self, this._then);

  final _StoryModel _self;
  final $Res Function(_StoryModel) _then;

  /// Create a copy of StoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? thumb = freezed,
    Object? process = freezed,
    Object? author = freezed,
    Object? viewed = freezed,
    Object? rating = freezed,
    Object? count = freezed,
  }) {
    return _then(_StoryModel(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      thumb: freezed == thumb
          ? _self.thumb
          : thumb // ignore: cast_nullable_to_non_nullable
              as String?,
      process: freezed == process
          ? _self.process
          : process // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      viewed: freezed == viewed
          ? _self.viewed
          : viewed // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      count: freezed == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
