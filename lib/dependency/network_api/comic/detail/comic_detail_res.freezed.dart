// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comic_detail_res.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ComicDetailRes {
  @JsonKey(name: 'seoOnPage')
  ComicSeoOnPage? get seoOnPage;
  @JsonKey(name: 'breadCrumb')
  List<ComicBreadCrumb>? get breadCrumb;
  @JsonKey(name: 'params')
  ComicParams? get params;
  @JsonKey(name: 'item')
  ComicItem? get item;
  @JsonKey(name: 'APP_DOMAIN_CDN_IMAGE')
  String? get appDomainCdnImage;

  /// Create a copy of ComicDetailRes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComicDetailResCopyWith<ComicDetailRes> get copyWith =>
      _$ComicDetailResCopyWithImpl<ComicDetailRes>(
          this as ComicDetailRes, _$identity);

  /// Serializes this ComicDetailRes to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComicDetailRes &&
            (identical(other.seoOnPage, seoOnPage) ||
                other.seoOnPage == seoOnPage) &&
            const DeepCollectionEquality()
                .equals(other.breadCrumb, breadCrumb) &&
            (identical(other.params, params) || other.params == params) &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.appDomainCdnImage, appDomainCdnImage) ||
                other.appDomainCdnImage == appDomainCdnImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      seoOnPage,
      const DeepCollectionEquality().hash(breadCrumb),
      params,
      item,
      appDomainCdnImage);

  @override
  String toString() {
    return 'ComicDetailRes(seoOnPage: $seoOnPage, breadCrumb: $breadCrumb, params: $params, item: $item, appDomainCdnImage: $appDomainCdnImage)';
  }
}

/// @nodoc
abstract mixin class $ComicDetailResCopyWith<$Res> {
  factory $ComicDetailResCopyWith(
          ComicDetailRes value, $Res Function(ComicDetailRes) _then) =
      _$ComicDetailResCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'seoOnPage') ComicSeoOnPage? seoOnPage,
      @JsonKey(name: 'breadCrumb') List<ComicBreadCrumb>? breadCrumb,
      @JsonKey(name: 'params') ComicParams? params,
      @JsonKey(name: 'item') ComicItem? item,
      @JsonKey(name: 'APP_DOMAIN_CDN_IMAGE') String? appDomainCdnImage});

  $ComicSeoOnPageCopyWith<$Res>? get seoOnPage;
  $ComicParamsCopyWith<$Res>? get params;
  $ComicItemCopyWith<$Res>? get item;
}

/// @nodoc
class _$ComicDetailResCopyWithImpl<$Res>
    implements $ComicDetailResCopyWith<$Res> {
  _$ComicDetailResCopyWithImpl(this._self, this._then);

  final ComicDetailRes _self;
  final $Res Function(ComicDetailRes) _then;

  /// Create a copy of ComicDetailRes
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seoOnPage = freezed,
    Object? breadCrumb = freezed,
    Object? params = freezed,
    Object? item = freezed,
    Object? appDomainCdnImage = freezed,
  }) {
    return _then(_self.copyWith(
      seoOnPage: freezed == seoOnPage
          ? _self.seoOnPage
          : seoOnPage // ignore: cast_nullable_to_non_nullable
              as ComicSeoOnPage?,
      breadCrumb: freezed == breadCrumb
          ? _self.breadCrumb
          : breadCrumb // ignore: cast_nullable_to_non_nullable
              as List<ComicBreadCrumb>?,
      params: freezed == params
          ? _self.params
          : params // ignore: cast_nullable_to_non_nullable
              as ComicParams?,
      item: freezed == item
          ? _self.item
          : item // ignore: cast_nullable_to_non_nullable
              as ComicItem?,
      appDomainCdnImage: freezed == appDomainCdnImage
          ? _self.appDomainCdnImage
          : appDomainCdnImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of ComicDetailRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComicSeoOnPageCopyWith<$Res>? get seoOnPage {
    if (_self.seoOnPage == null) {
      return null;
    }

    return $ComicSeoOnPageCopyWith<$Res>(_self.seoOnPage!, (value) {
      return _then(_self.copyWith(seoOnPage: value));
    });
  }

  /// Create a copy of ComicDetailRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComicParamsCopyWith<$Res>? get params {
    if (_self.params == null) {
      return null;
    }

    return $ComicParamsCopyWith<$Res>(_self.params!, (value) {
      return _then(_self.copyWith(params: value));
    });
  }

  /// Create a copy of ComicDetailRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComicItemCopyWith<$Res>? get item {
    if (_self.item == null) {
      return null;
    }

    return $ComicItemCopyWith<$Res>(_self.item!, (value) {
      return _then(_self.copyWith(item: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _ComicDetailRes implements ComicDetailRes {
  const _ComicDetailRes(
      {@JsonKey(name: 'seoOnPage') this.seoOnPage,
      @JsonKey(name: 'breadCrumb') final List<ComicBreadCrumb>? breadCrumb,
      @JsonKey(name: 'params') this.params,
      @JsonKey(name: 'item') this.item,
      @JsonKey(name: 'APP_DOMAIN_CDN_IMAGE') this.appDomainCdnImage})
      : _breadCrumb = breadCrumb;
  factory _ComicDetailRes.fromJson(Map<String, dynamic> json) =>
      _$ComicDetailResFromJson(json);

  @override
  @JsonKey(name: 'seoOnPage')
  final ComicSeoOnPage? seoOnPage;
  final List<ComicBreadCrumb>? _breadCrumb;
  @override
  @JsonKey(name: 'breadCrumb')
  List<ComicBreadCrumb>? get breadCrumb {
    final value = _breadCrumb;
    if (value == null) return null;
    if (_breadCrumb is EqualUnmodifiableListView) return _breadCrumb;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'params')
  final ComicParams? params;
  @override
  @JsonKey(name: 'item')
  final ComicItem? item;
  @override
  @JsonKey(name: 'APP_DOMAIN_CDN_IMAGE')
  final String? appDomainCdnImage;

  /// Create a copy of ComicDetailRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComicDetailResCopyWith<_ComicDetailRes> get copyWith =>
      __$ComicDetailResCopyWithImpl<_ComicDetailRes>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComicDetailResToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComicDetailRes &&
            (identical(other.seoOnPage, seoOnPage) ||
                other.seoOnPage == seoOnPage) &&
            const DeepCollectionEquality()
                .equals(other._breadCrumb, _breadCrumb) &&
            (identical(other.params, params) || other.params == params) &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.appDomainCdnImage, appDomainCdnImage) ||
                other.appDomainCdnImage == appDomainCdnImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      seoOnPage,
      const DeepCollectionEquality().hash(_breadCrumb),
      params,
      item,
      appDomainCdnImage);

  @override
  String toString() {
    return 'ComicDetailRes(seoOnPage: $seoOnPage, breadCrumb: $breadCrumb, params: $params, item: $item, appDomainCdnImage: $appDomainCdnImage)';
  }
}

/// @nodoc
abstract mixin class _$ComicDetailResCopyWith<$Res>
    implements $ComicDetailResCopyWith<$Res> {
  factory _$ComicDetailResCopyWith(
          _ComicDetailRes value, $Res Function(_ComicDetailRes) _then) =
      __$ComicDetailResCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'seoOnPage') ComicSeoOnPage? seoOnPage,
      @JsonKey(name: 'breadCrumb') List<ComicBreadCrumb>? breadCrumb,
      @JsonKey(name: 'params') ComicParams? params,
      @JsonKey(name: 'item') ComicItem? item,
      @JsonKey(name: 'APP_DOMAIN_CDN_IMAGE') String? appDomainCdnImage});

  @override
  $ComicSeoOnPageCopyWith<$Res>? get seoOnPage;
  @override
  $ComicParamsCopyWith<$Res>? get params;
  @override
  $ComicItemCopyWith<$Res>? get item;
}

/// @nodoc
class __$ComicDetailResCopyWithImpl<$Res>
    implements _$ComicDetailResCopyWith<$Res> {
  __$ComicDetailResCopyWithImpl(this._self, this._then);

  final _ComicDetailRes _self;
  final $Res Function(_ComicDetailRes) _then;

  /// Create a copy of ComicDetailRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? seoOnPage = freezed,
    Object? breadCrumb = freezed,
    Object? params = freezed,
    Object? item = freezed,
    Object? appDomainCdnImage = freezed,
  }) {
    return _then(_ComicDetailRes(
      seoOnPage: freezed == seoOnPage
          ? _self.seoOnPage
          : seoOnPage // ignore: cast_nullable_to_non_nullable
              as ComicSeoOnPage?,
      breadCrumb: freezed == breadCrumb
          ? _self._breadCrumb
          : breadCrumb // ignore: cast_nullable_to_non_nullable
              as List<ComicBreadCrumb>?,
      params: freezed == params
          ? _self.params
          : params // ignore: cast_nullable_to_non_nullable
              as ComicParams?,
      item: freezed == item
          ? _self.item
          : item // ignore: cast_nullable_to_non_nullable
              as ComicItem?,
      appDomainCdnImage: freezed == appDomainCdnImage
          ? _self.appDomainCdnImage
          : appDomainCdnImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of ComicDetailRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComicSeoOnPageCopyWith<$Res>? get seoOnPage {
    if (_self.seoOnPage == null) {
      return null;
    }

    return $ComicSeoOnPageCopyWith<$Res>(_self.seoOnPage!, (value) {
      return _then(_self.copyWith(seoOnPage: value));
    });
  }

  /// Create a copy of ComicDetailRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComicParamsCopyWith<$Res>? get params {
    if (_self.params == null) {
      return null;
    }

    return $ComicParamsCopyWith<$Res>(_self.params!, (value) {
      return _then(_self.copyWith(params: value));
    });
  }

  /// Create a copy of ComicDetailRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComicItemCopyWith<$Res>? get item {
    if (_self.item == null) {
      return null;
    }

    return $ComicItemCopyWith<$Res>(_self.item!, (value) {
      return _then(_self.copyWith(item: value));
    });
  }
}

/// @nodoc
mixin _$ComicSeoOnPage {
  @JsonKey(name: 'og_type')
  String? get ogType;
  @JsonKey(name: 'titleHead')
  String? get titleHead;
  @JsonKey(name: 'seoSchema')
  ComicSeoSchema? get seoSchema;
  @JsonKey(name: 'descriptionHead')
  String? get descriptionHead;
  @JsonKey(name: 'og_image')
  List<String>? get ogImage;
  @JsonKey(name: 'updated_time')
  int? get updatedTime;
  @JsonKey(name: 'og_url')
  String? get ogUrl;

  /// Create a copy of ComicSeoOnPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComicSeoOnPageCopyWith<ComicSeoOnPage> get copyWith =>
      _$ComicSeoOnPageCopyWithImpl<ComicSeoOnPage>(
          this as ComicSeoOnPage, _$identity);

  /// Serializes this ComicSeoOnPage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComicSeoOnPage &&
            (identical(other.ogType, ogType) || other.ogType == ogType) &&
            (identical(other.titleHead, titleHead) ||
                other.titleHead == titleHead) &&
            (identical(other.seoSchema, seoSchema) ||
                other.seoSchema == seoSchema) &&
            (identical(other.descriptionHead, descriptionHead) ||
                other.descriptionHead == descriptionHead) &&
            const DeepCollectionEquality().equals(other.ogImage, ogImage) &&
            (identical(other.updatedTime, updatedTime) ||
                other.updatedTime == updatedTime) &&
            (identical(other.ogUrl, ogUrl) || other.ogUrl == ogUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      ogType,
      titleHead,
      seoSchema,
      descriptionHead,
      const DeepCollectionEquality().hash(ogImage),
      updatedTime,
      ogUrl);

  @override
  String toString() {
    return 'ComicSeoOnPage(ogType: $ogType, titleHead: $titleHead, seoSchema: $seoSchema, descriptionHead: $descriptionHead, ogImage: $ogImage, updatedTime: $updatedTime, ogUrl: $ogUrl)';
  }
}

/// @nodoc
abstract mixin class $ComicSeoOnPageCopyWith<$Res> {
  factory $ComicSeoOnPageCopyWith(
          ComicSeoOnPage value, $Res Function(ComicSeoOnPage) _then) =
      _$ComicSeoOnPageCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'og_type') String? ogType,
      @JsonKey(name: 'titleHead') String? titleHead,
      @JsonKey(name: 'seoSchema') ComicSeoSchema? seoSchema,
      @JsonKey(name: 'descriptionHead') String? descriptionHead,
      @JsonKey(name: 'og_image') List<String>? ogImage,
      @JsonKey(name: 'updated_time') int? updatedTime,
      @JsonKey(name: 'og_url') String? ogUrl});

  $ComicSeoSchemaCopyWith<$Res>? get seoSchema;
}

/// @nodoc
class _$ComicSeoOnPageCopyWithImpl<$Res>
    implements $ComicSeoOnPageCopyWith<$Res> {
  _$ComicSeoOnPageCopyWithImpl(this._self, this._then);

  final ComicSeoOnPage _self;
  final $Res Function(ComicSeoOnPage) _then;

  /// Create a copy of ComicSeoOnPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ogType = freezed,
    Object? titleHead = freezed,
    Object? seoSchema = freezed,
    Object? descriptionHead = freezed,
    Object? ogImage = freezed,
    Object? updatedTime = freezed,
    Object? ogUrl = freezed,
  }) {
    return _then(_self.copyWith(
      ogType: freezed == ogType
          ? _self.ogType
          : ogType // ignore: cast_nullable_to_non_nullable
              as String?,
      titleHead: freezed == titleHead
          ? _self.titleHead
          : titleHead // ignore: cast_nullable_to_non_nullable
              as String?,
      seoSchema: freezed == seoSchema
          ? _self.seoSchema
          : seoSchema // ignore: cast_nullable_to_non_nullable
              as ComicSeoSchema?,
      descriptionHead: freezed == descriptionHead
          ? _self.descriptionHead
          : descriptionHead // ignore: cast_nullable_to_non_nullable
              as String?,
      ogImage: freezed == ogImage
          ? _self.ogImage
          : ogImage // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      updatedTime: freezed == updatedTime
          ? _self.updatedTime
          : updatedTime // ignore: cast_nullable_to_non_nullable
              as int?,
      ogUrl: freezed == ogUrl
          ? _self.ogUrl
          : ogUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of ComicSeoOnPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComicSeoSchemaCopyWith<$Res>? get seoSchema {
    if (_self.seoSchema == null) {
      return null;
    }

    return $ComicSeoSchemaCopyWith<$Res>(_self.seoSchema!, (value) {
      return _then(_self.copyWith(seoSchema: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _ComicSeoOnPage implements ComicSeoOnPage {
  const _ComicSeoOnPage(
      {@JsonKey(name: 'og_type') this.ogType,
      @JsonKey(name: 'titleHead') this.titleHead,
      @JsonKey(name: 'seoSchema') this.seoSchema,
      @JsonKey(name: 'descriptionHead') this.descriptionHead,
      @JsonKey(name: 'og_image') final List<String>? ogImage,
      @JsonKey(name: 'updated_time') this.updatedTime,
      @JsonKey(name: 'og_url') this.ogUrl})
      : _ogImage = ogImage;
  factory _ComicSeoOnPage.fromJson(Map<String, dynamic> json) =>
      _$ComicSeoOnPageFromJson(json);

  @override
  @JsonKey(name: 'og_type')
  final String? ogType;
  @override
  @JsonKey(name: 'titleHead')
  final String? titleHead;
  @override
  @JsonKey(name: 'seoSchema')
  final ComicSeoSchema? seoSchema;
  @override
  @JsonKey(name: 'descriptionHead')
  final String? descriptionHead;
  final List<String>? _ogImage;
  @override
  @JsonKey(name: 'og_image')
  List<String>? get ogImage {
    final value = _ogImage;
    if (value == null) return null;
    if (_ogImage is EqualUnmodifiableListView) return _ogImage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'updated_time')
  final int? updatedTime;
  @override
  @JsonKey(name: 'og_url')
  final String? ogUrl;

  /// Create a copy of ComicSeoOnPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComicSeoOnPageCopyWith<_ComicSeoOnPage> get copyWith =>
      __$ComicSeoOnPageCopyWithImpl<_ComicSeoOnPage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComicSeoOnPageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComicSeoOnPage &&
            (identical(other.ogType, ogType) || other.ogType == ogType) &&
            (identical(other.titleHead, titleHead) ||
                other.titleHead == titleHead) &&
            (identical(other.seoSchema, seoSchema) ||
                other.seoSchema == seoSchema) &&
            (identical(other.descriptionHead, descriptionHead) ||
                other.descriptionHead == descriptionHead) &&
            const DeepCollectionEquality().equals(other._ogImage, _ogImage) &&
            (identical(other.updatedTime, updatedTime) ||
                other.updatedTime == updatedTime) &&
            (identical(other.ogUrl, ogUrl) || other.ogUrl == ogUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      ogType,
      titleHead,
      seoSchema,
      descriptionHead,
      const DeepCollectionEquality().hash(_ogImage),
      updatedTime,
      ogUrl);

  @override
  String toString() {
    return 'ComicSeoOnPage(ogType: $ogType, titleHead: $titleHead, seoSchema: $seoSchema, descriptionHead: $descriptionHead, ogImage: $ogImage, updatedTime: $updatedTime, ogUrl: $ogUrl)';
  }
}

/// @nodoc
abstract mixin class _$ComicSeoOnPageCopyWith<$Res>
    implements $ComicSeoOnPageCopyWith<$Res> {
  factory _$ComicSeoOnPageCopyWith(
          _ComicSeoOnPage value, $Res Function(_ComicSeoOnPage) _then) =
      __$ComicSeoOnPageCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'og_type') String? ogType,
      @JsonKey(name: 'titleHead') String? titleHead,
      @JsonKey(name: 'seoSchema') ComicSeoSchema? seoSchema,
      @JsonKey(name: 'descriptionHead') String? descriptionHead,
      @JsonKey(name: 'og_image') List<String>? ogImage,
      @JsonKey(name: 'updated_time') int? updatedTime,
      @JsonKey(name: 'og_url') String? ogUrl});

  @override
  $ComicSeoSchemaCopyWith<$Res>? get seoSchema;
}

/// @nodoc
class __$ComicSeoOnPageCopyWithImpl<$Res>
    implements _$ComicSeoOnPageCopyWith<$Res> {
  __$ComicSeoOnPageCopyWithImpl(this._self, this._then);

  final _ComicSeoOnPage _self;
  final $Res Function(_ComicSeoOnPage) _then;

  /// Create a copy of ComicSeoOnPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? ogType = freezed,
    Object? titleHead = freezed,
    Object? seoSchema = freezed,
    Object? descriptionHead = freezed,
    Object? ogImage = freezed,
    Object? updatedTime = freezed,
    Object? ogUrl = freezed,
  }) {
    return _then(_ComicSeoOnPage(
      ogType: freezed == ogType
          ? _self.ogType
          : ogType // ignore: cast_nullable_to_non_nullable
              as String?,
      titleHead: freezed == titleHead
          ? _self.titleHead
          : titleHead // ignore: cast_nullable_to_non_nullable
              as String?,
      seoSchema: freezed == seoSchema
          ? _self.seoSchema
          : seoSchema // ignore: cast_nullable_to_non_nullable
              as ComicSeoSchema?,
      descriptionHead: freezed == descriptionHead
          ? _self.descriptionHead
          : descriptionHead // ignore: cast_nullable_to_non_nullable
              as String?,
      ogImage: freezed == ogImage
          ? _self._ogImage
          : ogImage // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      updatedTime: freezed == updatedTime
          ? _self.updatedTime
          : updatedTime // ignore: cast_nullable_to_non_nullable
              as int?,
      ogUrl: freezed == ogUrl
          ? _self.ogUrl
          : ogUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of ComicSeoOnPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComicSeoSchemaCopyWith<$Res>? get seoSchema {
    if (_self.seoSchema == null) {
      return null;
    }

    return $ComicSeoSchemaCopyWith<$Res>(_self.seoSchema!, (value) {
      return _then(_self.copyWith(seoSchema: value));
    });
  }
}

/// @nodoc
mixin _$ComicSeoSchema {
  @JsonKey(name: '@context')
  String? get context;
  @JsonKey(name: '@type')
  String? get type;
  @JsonKey(name: 'name')
  String? get name;
  @JsonKey(name: 'url')
  String? get url;
  @JsonKey(name: 'image')
  String? get image;
  @JsonKey(name: 'director')
  String? get director;

  /// Create a copy of ComicSeoSchema
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComicSeoSchemaCopyWith<ComicSeoSchema> get copyWith =>
      _$ComicSeoSchemaCopyWithImpl<ComicSeoSchema>(
          this as ComicSeoSchema, _$identity);

  /// Serializes this ComicSeoSchema to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComicSeoSchema &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.director, director) ||
                other.director == director));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, context, type, name, url, image, director);

  @override
  String toString() {
    return 'ComicSeoSchema(context: $context, type: $type, name: $name, url: $url, image: $image, director: $director)';
  }
}

/// @nodoc
abstract mixin class $ComicSeoSchemaCopyWith<$Res> {
  factory $ComicSeoSchemaCopyWith(
          ComicSeoSchema value, $Res Function(ComicSeoSchema) _then) =
      _$ComicSeoSchemaCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: '@context') String? context,
      @JsonKey(name: '@type') String? type,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'url') String? url,
      @JsonKey(name: 'image') String? image,
      @JsonKey(name: 'director') String? director});
}

/// @nodoc
class _$ComicSeoSchemaCopyWithImpl<$Res>
    implements $ComicSeoSchemaCopyWith<$Res> {
  _$ComicSeoSchemaCopyWithImpl(this._self, this._then);

  final ComicSeoSchema _self;
  final $Res Function(ComicSeoSchema) _then;

  /// Create a copy of ComicSeoSchema
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = freezed,
    Object? type = freezed,
    Object? name = freezed,
    Object? url = freezed,
    Object? image = freezed,
    Object? director = freezed,
  }) {
    return _then(_self.copyWith(
      context: freezed == context
          ? _self.context
          : context // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      director: freezed == director
          ? _self.director
          : director // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _ComicSeoSchema implements ComicSeoSchema {
  const _ComicSeoSchema(
      {@JsonKey(name: '@context') this.context,
      @JsonKey(name: '@type') this.type,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'url') this.url,
      @JsonKey(name: 'image') this.image,
      @JsonKey(name: 'director') this.director});
  factory _ComicSeoSchema.fromJson(Map<String, dynamic> json) =>
      _$ComicSeoSchemaFromJson(json);

  @override
  @JsonKey(name: '@context')
  final String? context;
  @override
  @JsonKey(name: '@type')
  final String? type;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'url')
  final String? url;
  @override
  @JsonKey(name: 'image')
  final String? image;
  @override
  @JsonKey(name: 'director')
  final String? director;

  /// Create a copy of ComicSeoSchema
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComicSeoSchemaCopyWith<_ComicSeoSchema> get copyWith =>
      __$ComicSeoSchemaCopyWithImpl<_ComicSeoSchema>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComicSeoSchemaToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComicSeoSchema &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.director, director) ||
                other.director == director));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, context, type, name, url, image, director);

  @override
  String toString() {
    return 'ComicSeoSchema(context: $context, type: $type, name: $name, url: $url, image: $image, director: $director)';
  }
}

/// @nodoc
abstract mixin class _$ComicSeoSchemaCopyWith<$Res>
    implements $ComicSeoSchemaCopyWith<$Res> {
  factory _$ComicSeoSchemaCopyWith(
          _ComicSeoSchema value, $Res Function(_ComicSeoSchema) _then) =
      __$ComicSeoSchemaCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '@context') String? context,
      @JsonKey(name: '@type') String? type,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'url') String? url,
      @JsonKey(name: 'image') String? image,
      @JsonKey(name: 'director') String? director});
}

/// @nodoc
class __$ComicSeoSchemaCopyWithImpl<$Res>
    implements _$ComicSeoSchemaCopyWith<$Res> {
  __$ComicSeoSchemaCopyWithImpl(this._self, this._then);

  final _ComicSeoSchema _self;
  final $Res Function(_ComicSeoSchema) _then;

  /// Create a copy of ComicSeoSchema
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? context = freezed,
    Object? type = freezed,
    Object? name = freezed,
    Object? url = freezed,
    Object? image = freezed,
    Object? director = freezed,
  }) {
    return _then(_ComicSeoSchema(
      context: freezed == context
          ? _self.context
          : context // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      director: freezed == director
          ? _self.director
          : director // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ComicBreadCrumb {
  @JsonKey(name: 'name')
  String? get name;
  @JsonKey(name: 'slug')
  String? get slug;
  @JsonKey(name: 'position')
  int? get position;
  @JsonKey(name: 'isCurrent')
  bool? get isCurrent;

  /// Create a copy of ComicBreadCrumb
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComicBreadCrumbCopyWith<ComicBreadCrumb> get copyWith =>
      _$ComicBreadCrumbCopyWithImpl<ComicBreadCrumb>(
          this as ComicBreadCrumb, _$identity);

  /// Serializes this ComicBreadCrumb to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComicBreadCrumb &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, slug, position, isCurrent);

  @override
  String toString() {
    return 'ComicBreadCrumb(name: $name, slug: $slug, position: $position, isCurrent: $isCurrent)';
  }
}

/// @nodoc
abstract mixin class $ComicBreadCrumbCopyWith<$Res> {
  factory $ComicBreadCrumbCopyWith(
          ComicBreadCrumb value, $Res Function(ComicBreadCrumb) _then) =
      _$ComicBreadCrumbCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'slug') String? slug,
      @JsonKey(name: 'position') int? position,
      @JsonKey(name: 'isCurrent') bool? isCurrent});
}

/// @nodoc
class _$ComicBreadCrumbCopyWithImpl<$Res>
    implements $ComicBreadCrumbCopyWith<$Res> {
  _$ComicBreadCrumbCopyWithImpl(this._self, this._then);

  final ComicBreadCrumb _self;
  final $Res Function(ComicBreadCrumb) _then;

  /// Create a copy of ComicBreadCrumb
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? slug = freezed,
    Object? position = freezed,
    Object? isCurrent = freezed,
  }) {
    return _then(_self.copyWith(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      isCurrent: freezed == isCurrent
          ? _self.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _ComicBreadCrumb implements ComicBreadCrumb {
  const _ComicBreadCrumb(
      {@JsonKey(name: 'name') this.name,
      @JsonKey(name: 'slug') this.slug,
      @JsonKey(name: 'position') this.position,
      @JsonKey(name: 'isCurrent') this.isCurrent});
  factory _ComicBreadCrumb.fromJson(Map<String, dynamic> json) =>
      _$ComicBreadCrumbFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'slug')
  final String? slug;
  @override
  @JsonKey(name: 'position')
  final int? position;
  @override
  @JsonKey(name: 'isCurrent')
  final bool? isCurrent;

  /// Create a copy of ComicBreadCrumb
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComicBreadCrumbCopyWith<_ComicBreadCrumb> get copyWith =>
      __$ComicBreadCrumbCopyWithImpl<_ComicBreadCrumb>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComicBreadCrumbToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComicBreadCrumb &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, slug, position, isCurrent);

  @override
  String toString() {
    return 'ComicBreadCrumb(name: $name, slug: $slug, position: $position, isCurrent: $isCurrent)';
  }
}

/// @nodoc
abstract mixin class _$ComicBreadCrumbCopyWith<$Res>
    implements $ComicBreadCrumbCopyWith<$Res> {
  factory _$ComicBreadCrumbCopyWith(
          _ComicBreadCrumb value, $Res Function(_ComicBreadCrumb) _then) =
      __$ComicBreadCrumbCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'slug') String? slug,
      @JsonKey(name: 'position') int? position,
      @JsonKey(name: 'isCurrent') bool? isCurrent});
}

/// @nodoc
class __$ComicBreadCrumbCopyWithImpl<$Res>
    implements _$ComicBreadCrumbCopyWith<$Res> {
  __$ComicBreadCrumbCopyWithImpl(this._self, this._then);

  final _ComicBreadCrumb _self;
  final $Res Function(_ComicBreadCrumb) _then;

  /// Create a copy of ComicBreadCrumb
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? slug = freezed,
    Object? position = freezed,
    Object? isCurrent = freezed,
  }) {
    return _then(_ComicBreadCrumb(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      isCurrent: freezed == isCurrent
          ? _self.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
mixin _$ComicParams {
  @JsonKey(name: 'slug')
  String? get slug;
  @JsonKey(name: 'crawl_check_url')
  String? get crawlCheckUrl;

  /// Create a copy of ComicParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComicParamsCopyWith<ComicParams> get copyWith =>
      _$ComicParamsCopyWithImpl<ComicParams>(this as ComicParams, _$identity);

  /// Serializes this ComicParams to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComicParams &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.crawlCheckUrl, crawlCheckUrl) ||
                other.crawlCheckUrl == crawlCheckUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, slug, crawlCheckUrl);

  @override
  String toString() {
    return 'ComicParams(slug: $slug, crawlCheckUrl: $crawlCheckUrl)';
  }
}

/// @nodoc
abstract mixin class $ComicParamsCopyWith<$Res> {
  factory $ComicParamsCopyWith(
          ComicParams value, $Res Function(ComicParams) _then) =
      _$ComicParamsCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'slug') String? slug,
      @JsonKey(name: 'crawl_check_url') String? crawlCheckUrl});
}

/// @nodoc
class _$ComicParamsCopyWithImpl<$Res> implements $ComicParamsCopyWith<$Res> {
  _$ComicParamsCopyWithImpl(this._self, this._then);

  final ComicParams _self;
  final $Res Function(ComicParams) _then;

  /// Create a copy of ComicParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = freezed,
    Object? crawlCheckUrl = freezed,
  }) {
    return _then(_self.copyWith(
      slug: freezed == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      crawlCheckUrl: freezed == crawlCheckUrl
          ? _self.crawlCheckUrl
          : crawlCheckUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _ComicParams implements ComicParams {
  const _ComicParams(
      {@JsonKey(name: 'slug') this.slug,
      @JsonKey(name: 'crawl_check_url') this.crawlCheckUrl});
  factory _ComicParams.fromJson(Map<String, dynamic> json) =>
      _$ComicParamsFromJson(json);

  @override
  @JsonKey(name: 'slug')
  final String? slug;
  @override
  @JsonKey(name: 'crawl_check_url')
  final String? crawlCheckUrl;

  /// Create a copy of ComicParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComicParamsCopyWith<_ComicParams> get copyWith =>
      __$ComicParamsCopyWithImpl<_ComicParams>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComicParamsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComicParams &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.crawlCheckUrl, crawlCheckUrl) ||
                other.crawlCheckUrl == crawlCheckUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, slug, crawlCheckUrl);

  @override
  String toString() {
    return 'ComicParams(slug: $slug, crawlCheckUrl: $crawlCheckUrl)';
  }
}

/// @nodoc
abstract mixin class _$ComicParamsCopyWith<$Res>
    implements $ComicParamsCopyWith<$Res> {
  factory _$ComicParamsCopyWith(
          _ComicParams value, $Res Function(_ComicParams) _then) =
      __$ComicParamsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'slug') String? slug,
      @JsonKey(name: 'crawl_check_url') String? crawlCheckUrl});
}

/// @nodoc
class __$ComicParamsCopyWithImpl<$Res> implements _$ComicParamsCopyWith<$Res> {
  __$ComicParamsCopyWithImpl(this._self, this._then);

  final _ComicParams _self;
  final $Res Function(_ComicParams) _then;

  /// Create a copy of ComicParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? slug = freezed,
    Object? crawlCheckUrl = freezed,
  }) {
    return _then(_ComicParams(
      slug: freezed == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      crawlCheckUrl: freezed == crawlCheckUrl
          ? _self.crawlCheckUrl
          : crawlCheckUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ComicItem {
  @JsonKey(name: '_id')
  String? get id;
  @JsonKey(name: 'name')
  String? get name;
  @JsonKey(name: 'slug')
  String? get slug;
  @JsonKey(name: 'origin_name')
  List<String>? get originName;
  @JsonKey(name: 'content')
  String? get content;
  @JsonKey(name: 'status')
  String? get status;
  @JsonKey(name: 'thumb_url')
  String? get thumbUrl;
  @JsonKey(name: 'sub_docquyen')
  bool? get subDocquyen;
  @JsonKey(name: 'author')
  List<String>? get author;
  @JsonKey(name: 'category')
  List<ComicCategory>? get category;
  @JsonKey(name: 'chapters')
  List<ComicChapterServer>? get chapters;
  @JsonKey(name: 'updatedAt')
  String? get updatedAt;

  /// Create a copy of ComicItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComicItemCopyWith<ComicItem> get copyWith =>
      _$ComicItemCopyWithImpl<ComicItem>(this as ComicItem, _$identity);

  /// Serializes this ComicItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComicItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            const DeepCollectionEquality()
                .equals(other.originName, originName) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.thumbUrl, thumbUrl) ||
                other.thumbUrl == thumbUrl) &&
            (identical(other.subDocquyen, subDocquyen) ||
                other.subDocquyen == subDocquyen) &&
            const DeepCollectionEquality().equals(other.author, author) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality().equals(other.chapters, chapters) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      slug,
      const DeepCollectionEquality().hash(originName),
      content,
      status,
      thumbUrl,
      subDocquyen,
      const DeepCollectionEquality().hash(author),
      const DeepCollectionEquality().hash(category),
      const DeepCollectionEquality().hash(chapters),
      updatedAt);

  @override
  String toString() {
    return 'ComicItem(id: $id, name: $name, slug: $slug, originName: $originName, content: $content, status: $status, thumbUrl: $thumbUrl, subDocquyen: $subDocquyen, author: $author, category: $category, chapters: $chapters, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $ComicItemCopyWith<$Res> {
  factory $ComicItemCopyWith(ComicItem value, $Res Function(ComicItem) _then) =
      _$ComicItemCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'slug') String? slug,
      @JsonKey(name: 'origin_name') List<String>? originName,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'status') String? status,
      @JsonKey(name: 'thumb_url') String? thumbUrl,
      @JsonKey(name: 'sub_docquyen') bool? subDocquyen,
      @JsonKey(name: 'author') List<String>? author,
      @JsonKey(name: 'category') List<ComicCategory>? category,
      @JsonKey(name: 'chapters') List<ComicChapterServer>? chapters,
      @JsonKey(name: 'updatedAt') String? updatedAt});
}

/// @nodoc
class _$ComicItemCopyWithImpl<$Res> implements $ComicItemCopyWith<$Res> {
  _$ComicItemCopyWithImpl(this._self, this._then);

  final ComicItem _self;
  final $Res Function(ComicItem) _then;

  /// Create a copy of ComicItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? slug = freezed,
    Object? originName = freezed,
    Object? content = freezed,
    Object? status = freezed,
    Object? thumbUrl = freezed,
    Object? subDocquyen = freezed,
    Object? author = freezed,
    Object? category = freezed,
    Object? chapters = freezed,
    Object? updatedAt = freezed,
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
      slug: freezed == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      originName: freezed == originName
          ? _self.originName
          : originName // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbUrl: freezed == thumbUrl
          ? _self.thumbUrl
          : thumbUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      subDocquyen: freezed == subDocquyen
          ? _self.subDocquyen
          : subDocquyen // ignore: cast_nullable_to_non_nullable
              as bool?,
      author: freezed == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as List<ComicCategory>?,
      chapters: freezed == chapters
          ? _self.chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<ComicChapterServer>?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _ComicItem implements ComicItem {
  const _ComicItem(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'slug') this.slug,
      @JsonKey(name: 'origin_name') final List<String>? originName,
      @JsonKey(name: 'content') this.content,
      @JsonKey(name: 'status') this.status,
      @JsonKey(name: 'thumb_url') this.thumbUrl,
      @JsonKey(name: 'sub_docquyen') this.subDocquyen,
      @JsonKey(name: 'author') final List<String>? author,
      @JsonKey(name: 'category') final List<ComicCategory>? category,
      @JsonKey(name: 'chapters') final List<ComicChapterServer>? chapters,
      @JsonKey(name: 'updatedAt') this.updatedAt})
      : _originName = originName,
        _author = author,
        _category = category,
        _chapters = chapters;
  factory _ComicItem.fromJson(Map<String, dynamic> json) =>
      _$ComicItemFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'slug')
  final String? slug;
  final List<String>? _originName;
  @override
  @JsonKey(name: 'origin_name')
  List<String>? get originName {
    final value = _originName;
    if (value == null) return null;
    if (_originName is EqualUnmodifiableListView) return _originName;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'content')
  final String? content;
  @override
  @JsonKey(name: 'status')
  final String? status;
  @override
  @JsonKey(name: 'thumb_url')
  final String? thumbUrl;
  @override
  @JsonKey(name: 'sub_docquyen')
  final bool? subDocquyen;
  final List<String>? _author;
  @override
  @JsonKey(name: 'author')
  List<String>? get author {
    final value = _author;
    if (value == null) return null;
    if (_author is EqualUnmodifiableListView) return _author;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ComicCategory>? _category;
  @override
  @JsonKey(name: 'category')
  List<ComicCategory>? get category {
    final value = _category;
    if (value == null) return null;
    if (_category is EqualUnmodifiableListView) return _category;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ComicChapterServer>? _chapters;
  @override
  @JsonKey(name: 'chapters')
  List<ComicChapterServer>? get chapters {
    final value = _chapters;
    if (value == null) return null;
    if (_chapters is EqualUnmodifiableListView) return _chapters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  /// Create a copy of ComicItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComicItemCopyWith<_ComicItem> get copyWith =>
      __$ComicItemCopyWithImpl<_ComicItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComicItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComicItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            const DeepCollectionEquality()
                .equals(other._originName, _originName) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.thumbUrl, thumbUrl) ||
                other.thumbUrl == thumbUrl) &&
            (identical(other.subDocquyen, subDocquyen) ||
                other.subDocquyen == subDocquyen) &&
            const DeepCollectionEquality().equals(other._author, _author) &&
            const DeepCollectionEquality().equals(other._category, _category) &&
            const DeepCollectionEquality().equals(other._chapters, _chapters) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      slug,
      const DeepCollectionEquality().hash(_originName),
      content,
      status,
      thumbUrl,
      subDocquyen,
      const DeepCollectionEquality().hash(_author),
      const DeepCollectionEquality().hash(_category),
      const DeepCollectionEquality().hash(_chapters),
      updatedAt);

  @override
  String toString() {
    return 'ComicItem(id: $id, name: $name, slug: $slug, originName: $originName, content: $content, status: $status, thumbUrl: $thumbUrl, subDocquyen: $subDocquyen, author: $author, category: $category, chapters: $chapters, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$ComicItemCopyWith<$Res>
    implements $ComicItemCopyWith<$Res> {
  factory _$ComicItemCopyWith(
          _ComicItem value, $Res Function(_ComicItem) _then) =
      __$ComicItemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'slug') String? slug,
      @JsonKey(name: 'origin_name') List<String>? originName,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'status') String? status,
      @JsonKey(name: 'thumb_url') String? thumbUrl,
      @JsonKey(name: 'sub_docquyen') bool? subDocquyen,
      @JsonKey(name: 'author') List<String>? author,
      @JsonKey(name: 'category') List<ComicCategory>? category,
      @JsonKey(name: 'chapters') List<ComicChapterServer>? chapters,
      @JsonKey(name: 'updatedAt') String? updatedAt});
}

/// @nodoc
class __$ComicItemCopyWithImpl<$Res> implements _$ComicItemCopyWith<$Res> {
  __$ComicItemCopyWithImpl(this._self, this._then);

  final _ComicItem _self;
  final $Res Function(_ComicItem) _then;

  /// Create a copy of ComicItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? slug = freezed,
    Object? originName = freezed,
    Object? content = freezed,
    Object? status = freezed,
    Object? thumbUrl = freezed,
    Object? subDocquyen = freezed,
    Object? author = freezed,
    Object? category = freezed,
    Object? chapters = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_ComicItem(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      originName: freezed == originName
          ? _self._originName
          : originName // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbUrl: freezed == thumbUrl
          ? _self.thumbUrl
          : thumbUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      subDocquyen: freezed == subDocquyen
          ? _self.subDocquyen
          : subDocquyen // ignore: cast_nullable_to_non_nullable
              as bool?,
      author: freezed == author
          ? _self._author
          : author // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      category: freezed == category
          ? _self._category
          : category // ignore: cast_nullable_to_non_nullable
              as List<ComicCategory>?,
      chapters: freezed == chapters
          ? _self._chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<ComicChapterServer>?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ComicCategory {
  @JsonKey(name: 'id')
  String? get id;
  @JsonKey(name: 'name')
  String? get name;
  @JsonKey(name: 'slug')
  String? get slug;

  /// Create a copy of ComicCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComicCategoryCopyWith<ComicCategory> get copyWith =>
      _$ComicCategoryCopyWithImpl<ComicCategory>(
          this as ComicCategory, _$identity);

  /// Serializes this ComicCategory to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComicCategory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, slug);

  @override
  String toString() {
    return 'ComicCategory(id: $id, name: $name, slug: $slug)';
  }
}

/// @nodoc
abstract mixin class $ComicCategoryCopyWith<$Res> {
  factory $ComicCategoryCopyWith(
          ComicCategory value, $Res Function(ComicCategory) _then) =
      _$ComicCategoryCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'slug') String? slug});
}

/// @nodoc
class _$ComicCategoryCopyWithImpl<$Res>
    implements $ComicCategoryCopyWith<$Res> {
  _$ComicCategoryCopyWithImpl(this._self, this._then);

  final ComicCategory _self;
  final $Res Function(ComicCategory) _then;

  /// Create a copy of ComicCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? slug = freezed,
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
      slug: freezed == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _ComicCategory implements ComicCategory {
  const _ComicCategory(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'slug') this.slug});
  factory _ComicCategory.fromJson(Map<String, dynamic> json) =>
      _$ComicCategoryFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'slug')
  final String? slug;

  /// Create a copy of ComicCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComicCategoryCopyWith<_ComicCategory> get copyWith =>
      __$ComicCategoryCopyWithImpl<_ComicCategory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComicCategoryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComicCategory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, slug);

  @override
  String toString() {
    return 'ComicCategory(id: $id, name: $name, slug: $slug)';
  }
}

/// @nodoc
abstract mixin class _$ComicCategoryCopyWith<$Res>
    implements $ComicCategoryCopyWith<$Res> {
  factory _$ComicCategoryCopyWith(
          _ComicCategory value, $Res Function(_ComicCategory) _then) =
      __$ComicCategoryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'slug') String? slug});
}

/// @nodoc
class __$ComicCategoryCopyWithImpl<$Res>
    implements _$ComicCategoryCopyWith<$Res> {
  __$ComicCategoryCopyWithImpl(this._self, this._then);

  final _ComicCategory _self;
  final $Res Function(_ComicCategory) _then;

  /// Create a copy of ComicCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? slug = freezed,
  }) {
    return _then(_ComicCategory(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ComicChapterServer {
  @JsonKey(name: 'server_name')
  String? get serverName;
  @JsonKey(name: 'server_data')
  List<ComicChapter>? get serverData;

  /// Create a copy of ComicChapterServer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComicChapterServerCopyWith<ComicChapterServer> get copyWith =>
      _$ComicChapterServerCopyWithImpl<ComicChapterServer>(
          this as ComicChapterServer, _$identity);

  /// Serializes this ComicChapterServer to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComicChapterServer &&
            (identical(other.serverName, serverName) ||
                other.serverName == serverName) &&
            const DeepCollectionEquality()
                .equals(other.serverData, serverData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, serverName, const DeepCollectionEquality().hash(serverData));

  @override
  String toString() {
    return 'ComicChapterServer(serverName: $serverName, serverData: $serverData)';
  }
}

/// @nodoc
abstract mixin class $ComicChapterServerCopyWith<$Res> {
  factory $ComicChapterServerCopyWith(
          ComicChapterServer value, $Res Function(ComicChapterServer) _then) =
      _$ComicChapterServerCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'server_name') String? serverName,
      @JsonKey(name: 'server_data') List<ComicChapter>? serverData});
}

/// @nodoc
class _$ComicChapterServerCopyWithImpl<$Res>
    implements $ComicChapterServerCopyWith<$Res> {
  _$ComicChapterServerCopyWithImpl(this._self, this._then);

  final ComicChapterServer _self;
  final $Res Function(ComicChapterServer) _then;

  /// Create a copy of ComicChapterServer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverName = freezed,
    Object? serverData = freezed,
  }) {
    return _then(_self.copyWith(
      serverName: freezed == serverName
          ? _self.serverName
          : serverName // ignore: cast_nullable_to_non_nullable
              as String?,
      serverData: freezed == serverData
          ? _self.serverData
          : serverData // ignore: cast_nullable_to_non_nullable
              as List<ComicChapter>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _ComicChapterServer implements ComicChapterServer {
  const _ComicChapterServer(
      {@JsonKey(name: 'server_name') this.serverName,
      @JsonKey(name: 'server_data') final List<ComicChapter>? serverData})
      : _serverData = serverData;
  factory _ComicChapterServer.fromJson(Map<String, dynamic> json) =>
      _$ComicChapterServerFromJson(json);

  @override
  @JsonKey(name: 'server_name')
  final String? serverName;
  final List<ComicChapter>? _serverData;
  @override
  @JsonKey(name: 'server_data')
  List<ComicChapter>? get serverData {
    final value = _serverData;
    if (value == null) return null;
    if (_serverData is EqualUnmodifiableListView) return _serverData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of ComicChapterServer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComicChapterServerCopyWith<_ComicChapterServer> get copyWith =>
      __$ComicChapterServerCopyWithImpl<_ComicChapterServer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComicChapterServerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComicChapterServer &&
            (identical(other.serverName, serverName) ||
                other.serverName == serverName) &&
            const DeepCollectionEquality()
                .equals(other._serverData, _serverData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, serverName,
      const DeepCollectionEquality().hash(_serverData));

  @override
  String toString() {
    return 'ComicChapterServer(serverName: $serverName, serverData: $serverData)';
  }
}

/// @nodoc
abstract mixin class _$ComicChapterServerCopyWith<$Res>
    implements $ComicChapterServerCopyWith<$Res> {
  factory _$ComicChapterServerCopyWith(
          _ComicChapterServer value, $Res Function(_ComicChapterServer) _then) =
      __$ComicChapterServerCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'server_name') String? serverName,
      @JsonKey(name: 'server_data') List<ComicChapter>? serverData});
}

/// @nodoc
class __$ComicChapterServerCopyWithImpl<$Res>
    implements _$ComicChapterServerCopyWith<$Res> {
  __$ComicChapterServerCopyWithImpl(this._self, this._then);

  final _ComicChapterServer _self;
  final $Res Function(_ComicChapterServer) _then;

  /// Create a copy of ComicChapterServer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? serverName = freezed,
    Object? serverData = freezed,
  }) {
    return _then(_ComicChapterServer(
      serverName: freezed == serverName
          ? _self.serverName
          : serverName // ignore: cast_nullable_to_non_nullable
              as String?,
      serverData: freezed == serverData
          ? _self._serverData
          : serverData // ignore: cast_nullable_to_non_nullable
              as List<ComicChapter>?,
    ));
  }
}

/// @nodoc
mixin _$ComicChapter {
  @JsonKey(name: 'filename')
  String? get filename;
  @JsonKey(name: 'chapter_name')
  String? get chapterName;
  @JsonKey(name: 'chapter_title')
  String? get chapterTitle;
  @JsonKey(name: 'chapter_api_data')
  String? get chapterApiData;

  /// Create a copy of ComicChapter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComicChapterCopyWith<ComicChapter> get copyWith =>
      _$ComicChapterCopyWithImpl<ComicChapter>(
          this as ComicChapter, _$identity);

  /// Serializes this ComicChapter to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComicChapter &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.chapterName, chapterName) ||
                other.chapterName == chapterName) &&
            (identical(other.chapterTitle, chapterTitle) ||
                other.chapterTitle == chapterTitle) &&
            (identical(other.chapterApiData, chapterApiData) ||
                other.chapterApiData == chapterApiData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, filename, chapterName, chapterTitle, chapterApiData);

  @override
  String toString() {
    return 'ComicChapter(filename: $filename, chapterName: $chapterName, chapterTitle: $chapterTitle, chapterApiData: $chapterApiData)';
  }
}

/// @nodoc
abstract mixin class $ComicChapterCopyWith<$Res> {
  factory $ComicChapterCopyWith(
          ComicChapter value, $Res Function(ComicChapter) _then) =
      _$ComicChapterCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'filename') String? filename,
      @JsonKey(name: 'chapter_name') String? chapterName,
      @JsonKey(name: 'chapter_title') String? chapterTitle,
      @JsonKey(name: 'chapter_api_data') String? chapterApiData});
}

/// @nodoc
class _$ComicChapterCopyWithImpl<$Res> implements $ComicChapterCopyWith<$Res> {
  _$ComicChapterCopyWithImpl(this._self, this._then);

  final ComicChapter _self;
  final $Res Function(ComicChapter) _then;

  /// Create a copy of ComicChapter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = freezed,
    Object? chapterName = freezed,
    Object? chapterTitle = freezed,
    Object? chapterApiData = freezed,
  }) {
    return _then(_self.copyWith(
      filename: freezed == filename
          ? _self.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterName: freezed == chapterName
          ? _self.chapterName
          : chapterName // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterTitle: freezed == chapterTitle
          ? _self.chapterTitle
          : chapterTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterApiData: freezed == chapterApiData
          ? _self.chapterApiData
          : chapterApiData // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _ComicChapter implements ComicChapter {
  const _ComicChapter(
      {@JsonKey(name: 'filename') this.filename,
      @JsonKey(name: 'chapter_name') this.chapterName,
      @JsonKey(name: 'chapter_title') this.chapterTitle,
      @JsonKey(name: 'chapter_api_data') this.chapterApiData});
  factory _ComicChapter.fromJson(Map<String, dynamic> json) =>
      _$ComicChapterFromJson(json);

  @override
  @JsonKey(name: 'filename')
  final String? filename;
  @override
  @JsonKey(name: 'chapter_name')
  final String? chapterName;
  @override
  @JsonKey(name: 'chapter_title')
  final String? chapterTitle;
  @override
  @JsonKey(name: 'chapter_api_data')
  final String? chapterApiData;

  /// Create a copy of ComicChapter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComicChapterCopyWith<_ComicChapter> get copyWith =>
      __$ComicChapterCopyWithImpl<_ComicChapter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComicChapterToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComicChapter &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.chapterName, chapterName) ||
                other.chapterName == chapterName) &&
            (identical(other.chapterTitle, chapterTitle) ||
                other.chapterTitle == chapterTitle) &&
            (identical(other.chapterApiData, chapterApiData) ||
                other.chapterApiData == chapterApiData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, filename, chapterName, chapterTitle, chapterApiData);

  @override
  String toString() {
    return 'ComicChapter(filename: $filename, chapterName: $chapterName, chapterTitle: $chapterTitle, chapterApiData: $chapterApiData)';
  }
}

/// @nodoc
abstract mixin class _$ComicChapterCopyWith<$Res>
    implements $ComicChapterCopyWith<$Res> {
  factory _$ComicChapterCopyWith(
          _ComicChapter value, $Res Function(_ComicChapter) _then) =
      __$ComicChapterCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'filename') String? filename,
      @JsonKey(name: 'chapter_name') String? chapterName,
      @JsonKey(name: 'chapter_title') String? chapterTitle,
      @JsonKey(name: 'chapter_api_data') String? chapterApiData});
}

/// @nodoc
class __$ComicChapterCopyWithImpl<$Res>
    implements _$ComicChapterCopyWith<$Res> {
  __$ComicChapterCopyWithImpl(this._self, this._then);

  final _ComicChapter _self;
  final $Res Function(_ComicChapter) _then;

  /// Create a copy of ComicChapter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? filename = freezed,
    Object? chapterName = freezed,
    Object? chapterTitle = freezed,
    Object? chapterApiData = freezed,
  }) {
    return _then(_ComicChapter(
      filename: freezed == filename
          ? _self.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterName: freezed == chapterName
          ? _self.chapterName
          : chapterName // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterTitle: freezed == chapterTitle
          ? _self.chapterTitle
          : chapterTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterApiData: freezed == chapterApiData
          ? _self.chapterApiData
          : chapterApiData // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
