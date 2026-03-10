// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comic_contents_res.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ComicContentsRes {
  @JsonKey(name: 'domain_cdn')
  String? get domainCdn;
  @JsonKey(name: 'item')
  ComicChapterItemModel? get item;

  /// Create a copy of ComicContentsRes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComicContentsResCopyWith<ComicContentsRes> get copyWith =>
      _$ComicContentsResCopyWithImpl<ComicContentsRes>(
          this as ComicContentsRes, _$identity);

  /// Serializes this ComicContentsRes to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComicContentsRes &&
            (identical(other.domainCdn, domainCdn) ||
                other.domainCdn == domainCdn) &&
            (identical(other.item, item) || other.item == item));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, domainCdn, item);

  @override
  String toString() {
    return 'ComicContentsRes(domainCdn: $domainCdn, item: $item)';
  }
}

/// @nodoc
abstract mixin class $ComicContentsResCopyWith<$Res> {
  factory $ComicContentsResCopyWith(
          ComicContentsRes value, $Res Function(ComicContentsRes) _then) =
      _$ComicContentsResCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'domain_cdn') String? domainCdn,
      @JsonKey(name: 'item') ComicChapterItemModel? item});

  $ComicChapterItemModelCopyWith<$Res>? get item;
}

/// @nodoc
class _$ComicContentsResCopyWithImpl<$Res>
    implements $ComicContentsResCopyWith<$Res> {
  _$ComicContentsResCopyWithImpl(this._self, this._then);

  final ComicContentsRes _self;
  final $Res Function(ComicContentsRes) _then;

  /// Create a copy of ComicContentsRes
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domainCdn = freezed,
    Object? item = freezed,
  }) {
    return _then(_self.copyWith(
      domainCdn: freezed == domainCdn
          ? _self.domainCdn
          : domainCdn // ignore: cast_nullable_to_non_nullable
              as String?,
      item: freezed == item
          ? _self.item
          : item // ignore: cast_nullable_to_non_nullable
              as ComicChapterItemModel?,
    ));
  }

  /// Create a copy of ComicContentsRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComicChapterItemModelCopyWith<$Res>? get item {
    if (_self.item == null) {
      return null;
    }

    return $ComicChapterItemModelCopyWith<$Res>(_self.item!, (value) {
      return _then(_self.copyWith(item: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _ComicContentsRes implements ComicContentsRes {
  const _ComicContentsRes(
      {@JsonKey(name: 'domain_cdn') this.domainCdn,
      @JsonKey(name: 'item') this.item});
  factory _ComicContentsRes.fromJson(Map<String, dynamic> json) =>
      _$ComicContentsResFromJson(json);

  @override
  @JsonKey(name: 'domain_cdn')
  final String? domainCdn;
  @override
  @JsonKey(name: 'item')
  final ComicChapterItemModel? item;

  /// Create a copy of ComicContentsRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComicContentsResCopyWith<_ComicContentsRes> get copyWith =>
      __$ComicContentsResCopyWithImpl<_ComicContentsRes>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComicContentsResToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComicContentsRes &&
            (identical(other.domainCdn, domainCdn) ||
                other.domainCdn == domainCdn) &&
            (identical(other.item, item) || other.item == item));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, domainCdn, item);

  @override
  String toString() {
    return 'ComicContentsRes(domainCdn: $domainCdn, item: $item)';
  }
}

/// @nodoc
abstract mixin class _$ComicContentsResCopyWith<$Res>
    implements $ComicContentsResCopyWith<$Res> {
  factory _$ComicContentsResCopyWith(
          _ComicContentsRes value, $Res Function(_ComicContentsRes) _then) =
      __$ComicContentsResCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'domain_cdn') String? domainCdn,
      @JsonKey(name: 'item') ComicChapterItemModel? item});

  @override
  $ComicChapterItemModelCopyWith<$Res>? get item;
}

/// @nodoc
class __$ComicContentsResCopyWithImpl<$Res>
    implements _$ComicContentsResCopyWith<$Res> {
  __$ComicContentsResCopyWithImpl(this._self, this._then);

  final _ComicContentsRes _self;
  final $Res Function(_ComicContentsRes) _then;

  /// Create a copy of ComicContentsRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? domainCdn = freezed,
    Object? item = freezed,
  }) {
    return _then(_ComicContentsRes(
      domainCdn: freezed == domainCdn
          ? _self.domainCdn
          : domainCdn // ignore: cast_nullable_to_non_nullable
              as String?,
      item: freezed == item
          ? _self.item
          : item // ignore: cast_nullable_to_non_nullable
              as ComicChapterItemModel?,
    ));
  }

  /// Create a copy of ComicContentsRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComicChapterItemModelCopyWith<$Res>? get item {
    if (_self.item == null) {
      return null;
    }

    return $ComicChapterItemModelCopyWith<$Res>(_self.item!, (value) {
      return _then(_self.copyWith(item: value));
    });
  }
}

/// @nodoc
mixin _$ComicChapterItemModel {
  @JsonKey(name: '_id')
  String? get id;
  @JsonKey(name: 'comic_name')
  String? get comicName;
  @JsonKey(name: 'chapter_name')
  String? get chapterName;
  @JsonKey(name: 'chapter_title')
  String? get chapterTitle;
  @JsonKey(name: 'chapter_path')
  String? get chapterPath;
  @JsonKey(name: 'chapter_image')
  List<ComicImagePageModel>? get chapterImage;

  /// Create a copy of ComicChapterItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComicChapterItemModelCopyWith<ComicChapterItemModel> get copyWith =>
      _$ComicChapterItemModelCopyWithImpl<ComicChapterItemModel>(
          this as ComicChapterItemModel, _$identity);

  /// Serializes this ComicChapterItemModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComicChapterItemModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.comicName, comicName) ||
                other.comicName == comicName) &&
            (identical(other.chapterName, chapterName) ||
                other.chapterName == chapterName) &&
            (identical(other.chapterTitle, chapterTitle) ||
                other.chapterTitle == chapterTitle) &&
            (identical(other.chapterPath, chapterPath) ||
                other.chapterPath == chapterPath) &&
            const DeepCollectionEquality()
                .equals(other.chapterImage, chapterImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      comicName,
      chapterName,
      chapterTitle,
      chapterPath,
      const DeepCollectionEquality().hash(chapterImage));

  @override
  String toString() {
    return 'ComicChapterItemModel(id: $id, comicName: $comicName, chapterName: $chapterName, chapterTitle: $chapterTitle, chapterPath: $chapterPath, chapterImage: $chapterImage)';
  }
}

/// @nodoc
abstract mixin class $ComicChapterItemModelCopyWith<$Res> {
  factory $ComicChapterItemModelCopyWith(ComicChapterItemModel value,
          $Res Function(ComicChapterItemModel) _then) =
      _$ComicChapterItemModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'comic_name') String? comicName,
      @JsonKey(name: 'chapter_name') String? chapterName,
      @JsonKey(name: 'chapter_title') String? chapterTitle,
      @JsonKey(name: 'chapter_path') String? chapterPath,
      @JsonKey(name: 'chapter_image') List<ComicImagePageModel>? chapterImage});
}

/// @nodoc
class _$ComicChapterItemModelCopyWithImpl<$Res>
    implements $ComicChapterItemModelCopyWith<$Res> {
  _$ComicChapterItemModelCopyWithImpl(this._self, this._then);

  final ComicChapterItemModel _self;
  final $Res Function(ComicChapterItemModel) _then;

  /// Create a copy of ComicChapterItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? comicName = freezed,
    Object? chapterName = freezed,
    Object? chapterTitle = freezed,
    Object? chapterPath = freezed,
    Object? chapterImage = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      comicName: freezed == comicName
          ? _self.comicName
          : comicName // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterName: freezed == chapterName
          ? _self.chapterName
          : chapterName // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterTitle: freezed == chapterTitle
          ? _self.chapterTitle
          : chapterTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterPath: freezed == chapterPath
          ? _self.chapterPath
          : chapterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterImage: freezed == chapterImage
          ? _self.chapterImage
          : chapterImage // ignore: cast_nullable_to_non_nullable
              as List<ComicImagePageModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ComicChapterItemModel implements ComicChapterItemModel {
  const _ComicChapterItemModel(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'comic_name') this.comicName,
      @JsonKey(name: 'chapter_name') this.chapterName,
      @JsonKey(name: 'chapter_title') this.chapterTitle,
      @JsonKey(name: 'chapter_path') this.chapterPath,
      @JsonKey(name: 'chapter_image')
      final List<ComicImagePageModel>? chapterImage})
      : _chapterImage = chapterImage;
  factory _ComicChapterItemModel.fromJson(Map<String, dynamic> json) =>
      _$ComicChapterItemModelFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'comic_name')
  final String? comicName;
  @override
  @JsonKey(name: 'chapter_name')
  final String? chapterName;
  @override
  @JsonKey(name: 'chapter_title')
  final String? chapterTitle;
  @override
  @JsonKey(name: 'chapter_path')
  final String? chapterPath;
  final List<ComicImagePageModel>? _chapterImage;
  @override
  @JsonKey(name: 'chapter_image')
  List<ComicImagePageModel>? get chapterImage {
    final value = _chapterImage;
    if (value == null) return null;
    if (_chapterImage is EqualUnmodifiableListView) return _chapterImage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of ComicChapterItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComicChapterItemModelCopyWith<_ComicChapterItemModel> get copyWith =>
      __$ComicChapterItemModelCopyWithImpl<_ComicChapterItemModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComicChapterItemModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComicChapterItemModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.comicName, comicName) ||
                other.comicName == comicName) &&
            (identical(other.chapterName, chapterName) ||
                other.chapterName == chapterName) &&
            (identical(other.chapterTitle, chapterTitle) ||
                other.chapterTitle == chapterTitle) &&
            (identical(other.chapterPath, chapterPath) ||
                other.chapterPath == chapterPath) &&
            const DeepCollectionEquality()
                .equals(other._chapterImage, _chapterImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      comicName,
      chapterName,
      chapterTitle,
      chapterPath,
      const DeepCollectionEquality().hash(_chapterImage));

  @override
  String toString() {
    return 'ComicChapterItemModel(id: $id, comicName: $comicName, chapterName: $chapterName, chapterTitle: $chapterTitle, chapterPath: $chapterPath, chapterImage: $chapterImage)';
  }
}

/// @nodoc
abstract mixin class _$ComicChapterItemModelCopyWith<$Res>
    implements $ComicChapterItemModelCopyWith<$Res> {
  factory _$ComicChapterItemModelCopyWith(_ComicChapterItemModel value,
          $Res Function(_ComicChapterItemModel) _then) =
      __$ComicChapterItemModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'comic_name') String? comicName,
      @JsonKey(name: 'chapter_name') String? chapterName,
      @JsonKey(name: 'chapter_title') String? chapterTitle,
      @JsonKey(name: 'chapter_path') String? chapterPath,
      @JsonKey(name: 'chapter_image') List<ComicImagePageModel>? chapterImage});
}

/// @nodoc
class __$ComicChapterItemModelCopyWithImpl<$Res>
    implements _$ComicChapterItemModelCopyWith<$Res> {
  __$ComicChapterItemModelCopyWithImpl(this._self, this._then);

  final _ComicChapterItemModel _self;
  final $Res Function(_ComicChapterItemModel) _then;

  /// Create a copy of ComicChapterItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? comicName = freezed,
    Object? chapterName = freezed,
    Object? chapterTitle = freezed,
    Object? chapterPath = freezed,
    Object? chapterImage = freezed,
  }) {
    return _then(_ComicChapterItemModel(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      comicName: freezed == comicName
          ? _self.comicName
          : comicName // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterName: freezed == chapterName
          ? _self.chapterName
          : chapterName // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterTitle: freezed == chapterTitle
          ? _self.chapterTitle
          : chapterTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterPath: freezed == chapterPath
          ? _self.chapterPath
          : chapterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterImage: freezed == chapterImage
          ? _self._chapterImage
          : chapterImage // ignore: cast_nullable_to_non_nullable
              as List<ComicImagePageModel>?,
    ));
  }
}

/// @nodoc
mixin _$ComicImagePageModel {
  @JsonKey(name: 'image_page')
  int? get imagePage;
  @JsonKey(name: 'image_file')
  String? get imageFile;

  /// Create a copy of ComicImagePageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComicImagePageModelCopyWith<ComicImagePageModel> get copyWith =>
      _$ComicImagePageModelCopyWithImpl<ComicImagePageModel>(
          this as ComicImagePageModel, _$identity);

  /// Serializes this ComicImagePageModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComicImagePageModel &&
            (identical(other.imagePage, imagePage) ||
                other.imagePage == imagePage) &&
            (identical(other.imageFile, imageFile) ||
                other.imageFile == imageFile));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, imagePage, imageFile);

  @override
  String toString() {
    return 'ComicImagePageModel(imagePage: $imagePage, imageFile: $imageFile)';
  }
}

/// @nodoc
abstract mixin class $ComicImagePageModelCopyWith<$Res> {
  factory $ComicImagePageModelCopyWith(
          ComicImagePageModel value, $Res Function(ComicImagePageModel) _then) =
      _$ComicImagePageModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'image_page') int? imagePage,
      @JsonKey(name: 'image_file') String? imageFile});
}

/// @nodoc
class _$ComicImagePageModelCopyWithImpl<$Res>
    implements $ComicImagePageModelCopyWith<$Res> {
  _$ComicImagePageModelCopyWithImpl(this._self, this._then);

  final ComicImagePageModel _self;
  final $Res Function(ComicImagePageModel) _then;

  /// Create a copy of ComicImagePageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imagePage = freezed,
    Object? imageFile = freezed,
  }) {
    return _then(_self.copyWith(
      imagePage: freezed == imagePage
          ? _self.imagePage
          : imagePage // ignore: cast_nullable_to_non_nullable
              as int?,
      imageFile: freezed == imageFile
          ? _self.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ComicImagePageModel implements ComicImagePageModel {
  const _ComicImagePageModel(
      {@JsonKey(name: 'image_page') this.imagePage,
      @JsonKey(name: 'image_file') this.imageFile});
  factory _ComicImagePageModel.fromJson(Map<String, dynamic> json) =>
      _$ComicImagePageModelFromJson(json);

  @override
  @JsonKey(name: 'image_page')
  final int? imagePage;
  @override
  @JsonKey(name: 'image_file')
  final String? imageFile;

  /// Create a copy of ComicImagePageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComicImagePageModelCopyWith<_ComicImagePageModel> get copyWith =>
      __$ComicImagePageModelCopyWithImpl<_ComicImagePageModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComicImagePageModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComicImagePageModel &&
            (identical(other.imagePage, imagePage) ||
                other.imagePage == imagePage) &&
            (identical(other.imageFile, imageFile) ||
                other.imageFile == imageFile));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, imagePage, imageFile);

  @override
  String toString() {
    return 'ComicImagePageModel(imagePage: $imagePage, imageFile: $imageFile)';
  }
}

/// @nodoc
abstract mixin class _$ComicImagePageModelCopyWith<$Res>
    implements $ComicImagePageModelCopyWith<$Res> {
  factory _$ComicImagePageModelCopyWith(_ComicImagePageModel value,
          $Res Function(_ComicImagePageModel) _then) =
      __$ComicImagePageModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'image_page') int? imagePage,
      @JsonKey(name: 'image_file') String? imageFile});
}

/// @nodoc
class __$ComicImagePageModelCopyWithImpl<$Res>
    implements _$ComicImagePageModelCopyWith<$Res> {
  __$ComicImagePageModelCopyWithImpl(this._self, this._then);

  final _ComicImagePageModel _self;
  final $Res Function(_ComicImagePageModel) _then;

  /// Create a copy of ComicImagePageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? imagePage = freezed,
    Object? imageFile = freezed,
  }) {
    return _then(_ComicImagePageModel(
      imagePage: freezed == imagePage
          ? _self.imagePage
          : imagePage // ignore: cast_nullable_to_non_nullable
              as int?,
      imageFile: freezed == imageFile
          ? _self.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
