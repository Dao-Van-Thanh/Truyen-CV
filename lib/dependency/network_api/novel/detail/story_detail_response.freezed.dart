// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_detail_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoryDetailResponse {
  @JsonKey(name: 'ID')
  String? get id;
  @JsonKey(name: 'NAME')
  String? get name;
  @JsonKey(name: 'CHAPTER')
  List<ChapterModel>? get chapter;
  @JsonKey(name: 'TOTALCHAPTER')
  String? get totalChapter;
  @JsonKey(name: 'IMG')
  String? get img;
  @JsonKey(name: 'CAT')
  String? get category;
  @JsonKey(name: 'AUTHOR')
  String? get author;
  @JsonKey(name: 'TRANS')
  String? get translator;
  @JsonKey(name: 'DESC')
  String? get description;
  @JsonKey(name: 'THUMB')
  String? get thumb;

  /// Create a copy of StoryDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StoryDetailResponseCopyWith<StoryDetailResponse> get copyWith =>
      _$StoryDetailResponseCopyWithImpl<StoryDetailResponse>(
          this as StoryDetailResponse, _$identity);

  /// Serializes this StoryDetailResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StoryDetailResponse &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.chapter, chapter) &&
            (identical(other.totalChapter, totalChapter) ||
                other.totalChapter == totalChapter) &&
            (identical(other.img, img) || other.img == img) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.translator, translator) ||
                other.translator == translator) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.thumb, thumb) || other.thumb == thumb));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(chapter),
      totalChapter,
      img,
      category,
      author,
      translator,
      description,
      thumb);

  @override
  String toString() {
    return 'StoryDetailResponse(id: $id, name: $name, chapter: $chapter, totalChapter: $totalChapter, img: $img, category: $category, author: $author, translator: $translator, description: $description, thumb: $thumb)';
  }
}

/// @nodoc
abstract mixin class $StoryDetailResponseCopyWith<$Res> {
  factory $StoryDetailResponseCopyWith(
          StoryDetailResponse value, $Res Function(StoryDetailResponse) _then) =
      _$StoryDetailResponseCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'ID') String? id,
      @JsonKey(name: 'NAME') String? name,
      @JsonKey(name: 'CHAPTER') List<ChapterModel>? chapter,
      @JsonKey(name: 'TOTALCHAPTER') String? totalChapter,
      @JsonKey(name: 'IMG') String? img,
      @JsonKey(name: 'CAT') String? category,
      @JsonKey(name: 'AUTHOR') String? author,
      @JsonKey(name: 'TRANS') String? translator,
      @JsonKey(name: 'DESC') String? description,
      @JsonKey(name: 'THUMB') String? thumb});
}

/// @nodoc
class _$StoryDetailResponseCopyWithImpl<$Res>
    implements $StoryDetailResponseCopyWith<$Res> {
  _$StoryDetailResponseCopyWithImpl(this._self, this._then);

  final StoryDetailResponse _self;
  final $Res Function(StoryDetailResponse) _then;

  /// Create a copy of StoryDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? chapter = freezed,
    Object? totalChapter = freezed,
    Object? img = freezed,
    Object? category = freezed,
    Object? author = freezed,
    Object? translator = freezed,
    Object? description = freezed,
    Object? thumb = freezed,
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
      chapter: freezed == chapter
          ? _self.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as List<ChapterModel>?,
      totalChapter: freezed == totalChapter
          ? _self.totalChapter
          : totalChapter // ignore: cast_nullable_to_non_nullable
              as String?,
      img: freezed == img
          ? _self.img
          : img // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      translator: freezed == translator
          ? _self.translator
          : translator // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      thumb: freezed == thumb
          ? _self.thumb
          : thumb // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _StoryDetailResponse implements StoryDetailResponse {
  const _StoryDetailResponse(
      {@JsonKey(name: 'ID') this.id,
      @JsonKey(name: 'NAME') this.name,
      @JsonKey(name: 'CHAPTER') final List<ChapterModel>? chapter,
      @JsonKey(name: 'TOTALCHAPTER') this.totalChapter,
      @JsonKey(name: 'IMG') this.img,
      @JsonKey(name: 'CAT') this.category,
      @JsonKey(name: 'AUTHOR') this.author,
      @JsonKey(name: 'TRANS') this.translator,
      @JsonKey(name: 'DESC') this.description,
      @JsonKey(name: 'THUMB') this.thumb})
      : _chapter = chapter;
  factory _StoryDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryDetailResponseFromJson(json);

  @override
  @JsonKey(name: 'ID')
  final String? id;
  @override
  @JsonKey(name: 'NAME')
  final String? name;
  final List<ChapterModel>? _chapter;
  @override
  @JsonKey(name: 'CHAPTER')
  List<ChapterModel>? get chapter {
    final value = _chapter;
    if (value == null) return null;
    if (_chapter is EqualUnmodifiableListView) return _chapter;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'TOTALCHAPTER')
  final String? totalChapter;
  @override
  @JsonKey(name: 'IMG')
  final String? img;
  @override
  @JsonKey(name: 'CAT')
  final String? category;
  @override
  @JsonKey(name: 'AUTHOR')
  final String? author;
  @override
  @JsonKey(name: 'TRANS')
  final String? translator;
  @override
  @JsonKey(name: 'DESC')
  final String? description;
  @override
  @JsonKey(name: 'THUMB')
  final String? thumb;

  /// Create a copy of StoryDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StoryDetailResponseCopyWith<_StoryDetailResponse> get copyWith =>
      __$StoryDetailResponseCopyWithImpl<_StoryDetailResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StoryDetailResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StoryDetailResponse &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._chapter, _chapter) &&
            (identical(other.totalChapter, totalChapter) ||
                other.totalChapter == totalChapter) &&
            (identical(other.img, img) || other.img == img) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.translator, translator) ||
                other.translator == translator) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.thumb, thumb) || other.thumb == thumb));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_chapter),
      totalChapter,
      img,
      category,
      author,
      translator,
      description,
      thumb);

  @override
  String toString() {
    return 'StoryDetailResponse(id: $id, name: $name, chapter: $chapter, totalChapter: $totalChapter, img: $img, category: $category, author: $author, translator: $translator, description: $description, thumb: $thumb)';
  }
}

/// @nodoc
abstract mixin class _$StoryDetailResponseCopyWith<$Res>
    implements $StoryDetailResponseCopyWith<$Res> {
  factory _$StoryDetailResponseCopyWith(_StoryDetailResponse value,
          $Res Function(_StoryDetailResponse) _then) =
      __$StoryDetailResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'ID') String? id,
      @JsonKey(name: 'NAME') String? name,
      @JsonKey(name: 'CHAPTER') List<ChapterModel>? chapter,
      @JsonKey(name: 'TOTALCHAPTER') String? totalChapter,
      @JsonKey(name: 'IMG') String? img,
      @JsonKey(name: 'CAT') String? category,
      @JsonKey(name: 'AUTHOR') String? author,
      @JsonKey(name: 'TRANS') String? translator,
      @JsonKey(name: 'DESC') String? description,
      @JsonKey(name: 'THUMB') String? thumb});
}

/// @nodoc
class __$StoryDetailResponseCopyWithImpl<$Res>
    implements _$StoryDetailResponseCopyWith<$Res> {
  __$StoryDetailResponseCopyWithImpl(this._self, this._then);

  final _StoryDetailResponse _self;
  final $Res Function(_StoryDetailResponse) _then;

  /// Create a copy of StoryDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? chapter = freezed,
    Object? totalChapter = freezed,
    Object? img = freezed,
    Object? category = freezed,
    Object? author = freezed,
    Object? translator = freezed,
    Object? description = freezed,
    Object? thumb = freezed,
  }) {
    return _then(_StoryDetailResponse(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      chapter: freezed == chapter
          ? _self._chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as List<ChapterModel>?,
      totalChapter: freezed == totalChapter
          ? _self.totalChapter
          : totalChapter // ignore: cast_nullable_to_non_nullable
              as String?,
      img: freezed == img
          ? _self.img
          : img // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      translator: freezed == translator
          ? _self.translator
          : translator // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      thumb: freezed == thumb
          ? _self.thumb
          : thumb // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ChapterModel {
  @JsonKey(name: 'id')
  String? get id;
  @JsonKey(name: 'name')
  String? get name;

  /// Create a copy of ChapterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChapterModelCopyWith<ChapterModel> get copyWith =>
      _$ChapterModelCopyWithImpl<ChapterModel>(
          this as ChapterModel, _$identity);

  /// Serializes this ChapterModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChapterModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @override
  String toString() {
    return 'ChapterModel(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class $ChapterModelCopyWith<$Res> {
  factory $ChapterModelCopyWith(
          ChapterModel value, $Res Function(ChapterModel) _then) =
      _$ChapterModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id, @JsonKey(name: 'name') String? name});
}

/// @nodoc
class _$ChapterModelCopyWithImpl<$Res> implements $ChapterModelCopyWith<$Res> {
  _$ChapterModelCopyWithImpl(this._self, this._then);

  final ChapterModel _self;
  final $Res Function(ChapterModel) _then;

  /// Create a copy of ChapterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ChapterModel implements ChapterModel {
  const _ChapterModel(
      {@JsonKey(name: 'id') this.id, @JsonKey(name: 'name') this.name});
  factory _ChapterModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterModelFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'name')
  final String? name;

  /// Create a copy of ChapterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChapterModelCopyWith<_ChapterModel> get copyWith =>
      __$ChapterModelCopyWithImpl<_ChapterModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChapterModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChapterModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @override
  String toString() {
    return 'ChapterModel(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$ChapterModelCopyWith<$Res>
    implements $ChapterModelCopyWith<$Res> {
  factory _$ChapterModelCopyWith(
          _ChapterModel value, $Res Function(_ChapterModel) _then) =
      __$ChapterModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id, @JsonKey(name: 'name') String? name});
}

/// @nodoc
class __$ChapterModelCopyWithImpl<$Res>
    implements _$ChapterModelCopyWith<$Res> {
  __$ChapterModelCopyWithImpl(this._self, this._then);

  final _ChapterModel _self;
  final $Res Function(_ChapterModel) _then;

  /// Create a copy of ChapterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_ChapterModel(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
