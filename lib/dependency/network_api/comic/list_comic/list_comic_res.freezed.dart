// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_comic_res.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListComicRes {
  @JsonKey(name: 'seoOnPage')
  SeoOnPageModel? get seoOnPage;
  @JsonKey(name: 'breadCrumb')
  List<BreadCrumbModel>? get breadCrumb;
  @JsonKey(name: 'titlePage')
  String? get titlePage;
  @JsonKey(name: 'items')
  List<StoryItemModel>? get items;
  @JsonKey(name: 'params')
  ParamsModel? get params;
  @JsonKey(name: 'type_list')
  String? get typeList;
  @JsonKey(name: 'APP_DOMAIN_FRONTEND')
  String? get appDomainFrontend;
  @JsonKey(name: 'APP_DOMAIN_CDN_IMAGE')
  String? get appDomainCdnImage;

  /// Create a copy of ListComicRes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ListComicResCopyWith<ListComicRes> get copyWith =>
      _$ListComicResCopyWithImpl<ListComicRes>(
          this as ListComicRes, _$identity);

  /// Serializes this ListComicRes to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ListComicRes &&
            (identical(other.seoOnPage, seoOnPage) ||
                other.seoOnPage == seoOnPage) &&
            const DeepCollectionEquality()
                .equals(other.breadCrumb, breadCrumb) &&
            (identical(other.titlePage, titlePage) ||
                other.titlePage == titlePage) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.params, params) || other.params == params) &&
            (identical(other.typeList, typeList) ||
                other.typeList == typeList) &&
            (identical(other.appDomainFrontend, appDomainFrontend) ||
                other.appDomainFrontend == appDomainFrontend) &&
            (identical(other.appDomainCdnImage, appDomainCdnImage) ||
                other.appDomainCdnImage == appDomainCdnImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      seoOnPage,
      const DeepCollectionEquality().hash(breadCrumb),
      titlePage,
      const DeepCollectionEquality().hash(items),
      params,
      typeList,
      appDomainFrontend,
      appDomainCdnImage);

  @override
  String toString() {
    return 'ListComicRes(seoOnPage: $seoOnPage, breadCrumb: $breadCrumb, titlePage: $titlePage, items: $items, params: $params, typeList: $typeList, appDomainFrontend: $appDomainFrontend, appDomainCdnImage: $appDomainCdnImage)';
  }
}

/// @nodoc
abstract mixin class $ListComicResCopyWith<$Res> {
  factory $ListComicResCopyWith(
          ListComicRes value, $Res Function(ListComicRes) _then) =
      _$ListComicResCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'seoOnPage') SeoOnPageModel? seoOnPage,
      @JsonKey(name: 'breadCrumb') List<BreadCrumbModel>? breadCrumb,
      @JsonKey(name: 'titlePage') String? titlePage,
      @JsonKey(name: 'items') List<StoryItemModel>? items,
      @JsonKey(name: 'params') ParamsModel? params,
      @JsonKey(name: 'type_list') String? typeList,
      @JsonKey(name: 'APP_DOMAIN_FRONTEND') String? appDomainFrontend,
      @JsonKey(name: 'APP_DOMAIN_CDN_IMAGE') String? appDomainCdnImage});

  $SeoOnPageModelCopyWith<$Res>? get seoOnPage;
  $ParamsModelCopyWith<$Res>? get params;
}

/// @nodoc
class _$ListComicResCopyWithImpl<$Res> implements $ListComicResCopyWith<$Res> {
  _$ListComicResCopyWithImpl(this._self, this._then);

  final ListComicRes _self;
  final $Res Function(ListComicRes) _then;

  /// Create a copy of ListComicRes
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seoOnPage = freezed,
    Object? breadCrumb = freezed,
    Object? titlePage = freezed,
    Object? items = freezed,
    Object? params = freezed,
    Object? typeList = freezed,
    Object? appDomainFrontend = freezed,
    Object? appDomainCdnImage = freezed,
  }) {
    return _then(_self.copyWith(
      seoOnPage: freezed == seoOnPage
          ? _self.seoOnPage
          : seoOnPage // ignore: cast_nullable_to_non_nullable
              as SeoOnPageModel?,
      breadCrumb: freezed == breadCrumb
          ? _self.breadCrumb
          : breadCrumb // ignore: cast_nullable_to_non_nullable
              as List<BreadCrumbModel>?,
      titlePage: freezed == titlePage
          ? _self.titlePage
          : titlePage // ignore: cast_nullable_to_non_nullable
              as String?,
      items: freezed == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<StoryItemModel>?,
      params: freezed == params
          ? _self.params
          : params // ignore: cast_nullable_to_non_nullable
              as ParamsModel?,
      typeList: freezed == typeList
          ? _self.typeList
          : typeList // ignore: cast_nullable_to_non_nullable
              as String?,
      appDomainFrontend: freezed == appDomainFrontend
          ? _self.appDomainFrontend
          : appDomainFrontend // ignore: cast_nullable_to_non_nullable
              as String?,
      appDomainCdnImage: freezed == appDomainCdnImage
          ? _self.appDomainCdnImage
          : appDomainCdnImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of ListComicRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeoOnPageModelCopyWith<$Res>? get seoOnPage {
    if (_self.seoOnPage == null) {
      return null;
    }

    return $SeoOnPageModelCopyWith<$Res>(_self.seoOnPage!, (value) {
      return _then(_self.copyWith(seoOnPage: value));
    });
  }

  /// Create a copy of ListComicRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ParamsModelCopyWith<$Res>? get params {
    if (_self.params == null) {
      return null;
    }

    return $ParamsModelCopyWith<$Res>(_self.params!, (value) {
      return _then(_self.copyWith(params: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _ListComicRes implements ListComicRes {
  const _ListComicRes(
      {@JsonKey(name: 'seoOnPage') this.seoOnPage,
      @JsonKey(name: 'breadCrumb') final List<BreadCrumbModel>? breadCrumb,
      @JsonKey(name: 'titlePage') this.titlePage,
      @JsonKey(name: 'items') final List<StoryItemModel>? items,
      @JsonKey(name: 'params') this.params,
      @JsonKey(name: 'type_list') this.typeList,
      @JsonKey(name: 'APP_DOMAIN_FRONTEND') this.appDomainFrontend,
      @JsonKey(name: 'APP_DOMAIN_CDN_IMAGE') this.appDomainCdnImage})
      : _breadCrumb = breadCrumb,
        _items = items;
  factory _ListComicRes.fromJson(Map<String, dynamic> json) =>
      _$ListComicResFromJson(json);

  @override
  @JsonKey(name: 'seoOnPage')
  final SeoOnPageModel? seoOnPage;
  final List<BreadCrumbModel>? _breadCrumb;
  @override
  @JsonKey(name: 'breadCrumb')
  List<BreadCrumbModel>? get breadCrumb {
    final value = _breadCrumb;
    if (value == null) return null;
    if (_breadCrumb is EqualUnmodifiableListView) return _breadCrumb;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'titlePage')
  final String? titlePage;
  final List<StoryItemModel>? _items;
  @override
  @JsonKey(name: 'items')
  List<StoryItemModel>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'params')
  final ParamsModel? params;
  @override
  @JsonKey(name: 'type_list')
  final String? typeList;
  @override
  @JsonKey(name: 'APP_DOMAIN_FRONTEND')
  final String? appDomainFrontend;
  @override
  @JsonKey(name: 'APP_DOMAIN_CDN_IMAGE')
  final String? appDomainCdnImage;

  /// Create a copy of ListComicRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ListComicResCopyWith<_ListComicRes> get copyWith =>
      __$ListComicResCopyWithImpl<_ListComicRes>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ListComicResToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ListComicRes &&
            (identical(other.seoOnPage, seoOnPage) ||
                other.seoOnPage == seoOnPage) &&
            const DeepCollectionEquality()
                .equals(other._breadCrumb, _breadCrumb) &&
            (identical(other.titlePage, titlePage) ||
                other.titlePage == titlePage) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.params, params) || other.params == params) &&
            (identical(other.typeList, typeList) ||
                other.typeList == typeList) &&
            (identical(other.appDomainFrontend, appDomainFrontend) ||
                other.appDomainFrontend == appDomainFrontend) &&
            (identical(other.appDomainCdnImage, appDomainCdnImage) ||
                other.appDomainCdnImage == appDomainCdnImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      seoOnPage,
      const DeepCollectionEquality().hash(_breadCrumb),
      titlePage,
      const DeepCollectionEquality().hash(_items),
      params,
      typeList,
      appDomainFrontend,
      appDomainCdnImage);

  @override
  String toString() {
    return 'ListComicRes(seoOnPage: $seoOnPage, breadCrumb: $breadCrumb, titlePage: $titlePage, items: $items, params: $params, typeList: $typeList, appDomainFrontend: $appDomainFrontend, appDomainCdnImage: $appDomainCdnImage)';
  }
}

/// @nodoc
abstract mixin class _$ListComicResCopyWith<$Res>
    implements $ListComicResCopyWith<$Res> {
  factory _$ListComicResCopyWith(
          _ListComicRes value, $Res Function(_ListComicRes) _then) =
      __$ListComicResCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'seoOnPage') SeoOnPageModel? seoOnPage,
      @JsonKey(name: 'breadCrumb') List<BreadCrumbModel>? breadCrumb,
      @JsonKey(name: 'titlePage') String? titlePage,
      @JsonKey(name: 'items') List<StoryItemModel>? items,
      @JsonKey(name: 'params') ParamsModel? params,
      @JsonKey(name: 'type_list') String? typeList,
      @JsonKey(name: 'APP_DOMAIN_FRONTEND') String? appDomainFrontend,
      @JsonKey(name: 'APP_DOMAIN_CDN_IMAGE') String? appDomainCdnImage});

  @override
  $SeoOnPageModelCopyWith<$Res>? get seoOnPage;
  @override
  $ParamsModelCopyWith<$Res>? get params;
}

/// @nodoc
class __$ListComicResCopyWithImpl<$Res>
    implements _$ListComicResCopyWith<$Res> {
  __$ListComicResCopyWithImpl(this._self, this._then);

  final _ListComicRes _self;
  final $Res Function(_ListComicRes) _then;

  /// Create a copy of ListComicRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? seoOnPage = freezed,
    Object? breadCrumb = freezed,
    Object? titlePage = freezed,
    Object? items = freezed,
    Object? params = freezed,
    Object? typeList = freezed,
    Object? appDomainFrontend = freezed,
    Object? appDomainCdnImage = freezed,
  }) {
    return _then(_ListComicRes(
      seoOnPage: freezed == seoOnPage
          ? _self.seoOnPage
          : seoOnPage // ignore: cast_nullable_to_non_nullable
              as SeoOnPageModel?,
      breadCrumb: freezed == breadCrumb
          ? _self._breadCrumb
          : breadCrumb // ignore: cast_nullable_to_non_nullable
              as List<BreadCrumbModel>?,
      titlePage: freezed == titlePage
          ? _self.titlePage
          : titlePage // ignore: cast_nullable_to_non_nullable
              as String?,
      items: freezed == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<StoryItemModel>?,
      params: freezed == params
          ? _self.params
          : params // ignore: cast_nullable_to_non_nullable
              as ParamsModel?,
      typeList: freezed == typeList
          ? _self.typeList
          : typeList // ignore: cast_nullable_to_non_nullable
              as String?,
      appDomainFrontend: freezed == appDomainFrontend
          ? _self.appDomainFrontend
          : appDomainFrontend // ignore: cast_nullable_to_non_nullable
              as String?,
      appDomainCdnImage: freezed == appDomainCdnImage
          ? _self.appDomainCdnImage
          : appDomainCdnImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of ListComicRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeoOnPageModelCopyWith<$Res>? get seoOnPage {
    if (_self.seoOnPage == null) {
      return null;
    }

    return $SeoOnPageModelCopyWith<$Res>(_self.seoOnPage!, (value) {
      return _then(_self.copyWith(seoOnPage: value));
    });
  }

  /// Create a copy of ListComicRes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ParamsModelCopyWith<$Res>? get params {
    if (_self.params == null) {
      return null;
    }

    return $ParamsModelCopyWith<$Res>(_self.params!, (value) {
      return _then(_self.copyWith(params: value));
    });
  }
}

/// @nodoc
mixin _$SeoOnPageModel {
  @JsonKey(name: 'og_type')
  String? get ogType;
  @JsonKey(name: 'titleHead')
  String? get titleHead;
  @JsonKey(name: 'descriptionHead')
  String? get descriptionHead;
  @JsonKey(name: 'og_image')
  List<String>? get ogImage;
  @JsonKey(name: 'og_url')
  String? get ogUrl;

  /// Create a copy of SeoOnPageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeoOnPageModelCopyWith<SeoOnPageModel> get copyWith =>
      _$SeoOnPageModelCopyWithImpl<SeoOnPageModel>(
          this as SeoOnPageModel, _$identity);

  /// Serializes this SeoOnPageModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SeoOnPageModel &&
            (identical(other.ogType, ogType) || other.ogType == ogType) &&
            (identical(other.titleHead, titleHead) ||
                other.titleHead == titleHead) &&
            (identical(other.descriptionHead, descriptionHead) ||
                other.descriptionHead == descriptionHead) &&
            const DeepCollectionEquality().equals(other.ogImage, ogImage) &&
            (identical(other.ogUrl, ogUrl) || other.ogUrl == ogUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ogType, titleHead,
      descriptionHead, const DeepCollectionEquality().hash(ogImage), ogUrl);

  @override
  String toString() {
    return 'SeoOnPageModel(ogType: $ogType, titleHead: $titleHead, descriptionHead: $descriptionHead, ogImage: $ogImage, ogUrl: $ogUrl)';
  }
}

/// @nodoc
abstract mixin class $SeoOnPageModelCopyWith<$Res> {
  factory $SeoOnPageModelCopyWith(
          SeoOnPageModel value, $Res Function(SeoOnPageModel) _then) =
      _$SeoOnPageModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'og_type') String? ogType,
      @JsonKey(name: 'titleHead') String? titleHead,
      @JsonKey(name: 'descriptionHead') String? descriptionHead,
      @JsonKey(name: 'og_image') List<String>? ogImage,
      @JsonKey(name: 'og_url') String? ogUrl});
}

/// @nodoc
class _$SeoOnPageModelCopyWithImpl<$Res>
    implements $SeoOnPageModelCopyWith<$Res> {
  _$SeoOnPageModelCopyWithImpl(this._self, this._then);

  final SeoOnPageModel _self;
  final $Res Function(SeoOnPageModel) _then;

  /// Create a copy of SeoOnPageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ogType = freezed,
    Object? titleHead = freezed,
    Object? descriptionHead = freezed,
    Object? ogImage = freezed,
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
      descriptionHead: freezed == descriptionHead
          ? _self.descriptionHead
          : descriptionHead // ignore: cast_nullable_to_non_nullable
              as String?,
      ogImage: freezed == ogImage
          ? _self.ogImage
          : ogImage // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      ogUrl: freezed == ogUrl
          ? _self.ogUrl
          : ogUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SeoOnPageModel implements SeoOnPageModel {
  const _SeoOnPageModel(
      {@JsonKey(name: 'og_type') this.ogType,
      @JsonKey(name: 'titleHead') this.titleHead,
      @JsonKey(name: 'descriptionHead') this.descriptionHead,
      @JsonKey(name: 'og_image') final List<String>? ogImage,
      @JsonKey(name: 'og_url') this.ogUrl})
      : _ogImage = ogImage;
  factory _SeoOnPageModel.fromJson(Map<String, dynamic> json) =>
      _$SeoOnPageModelFromJson(json);

  @override
  @JsonKey(name: 'og_type')
  final String? ogType;
  @override
  @JsonKey(name: 'titleHead')
  final String? titleHead;
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
  @JsonKey(name: 'og_url')
  final String? ogUrl;

  /// Create a copy of SeoOnPageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeoOnPageModelCopyWith<_SeoOnPageModel> get copyWith =>
      __$SeoOnPageModelCopyWithImpl<_SeoOnPageModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SeoOnPageModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SeoOnPageModel &&
            (identical(other.ogType, ogType) || other.ogType == ogType) &&
            (identical(other.titleHead, titleHead) ||
                other.titleHead == titleHead) &&
            (identical(other.descriptionHead, descriptionHead) ||
                other.descriptionHead == descriptionHead) &&
            const DeepCollectionEquality().equals(other._ogImage, _ogImage) &&
            (identical(other.ogUrl, ogUrl) || other.ogUrl == ogUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ogType, titleHead,
      descriptionHead, const DeepCollectionEquality().hash(_ogImage), ogUrl);

  @override
  String toString() {
    return 'SeoOnPageModel(ogType: $ogType, titleHead: $titleHead, descriptionHead: $descriptionHead, ogImage: $ogImage, ogUrl: $ogUrl)';
  }
}

/// @nodoc
abstract mixin class _$SeoOnPageModelCopyWith<$Res>
    implements $SeoOnPageModelCopyWith<$Res> {
  factory _$SeoOnPageModelCopyWith(
          _SeoOnPageModel value, $Res Function(_SeoOnPageModel) _then) =
      __$SeoOnPageModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'og_type') String? ogType,
      @JsonKey(name: 'titleHead') String? titleHead,
      @JsonKey(name: 'descriptionHead') String? descriptionHead,
      @JsonKey(name: 'og_image') List<String>? ogImage,
      @JsonKey(name: 'og_url') String? ogUrl});
}

/// @nodoc
class __$SeoOnPageModelCopyWithImpl<$Res>
    implements _$SeoOnPageModelCopyWith<$Res> {
  __$SeoOnPageModelCopyWithImpl(this._self, this._then);

  final _SeoOnPageModel _self;
  final $Res Function(_SeoOnPageModel) _then;

  /// Create a copy of SeoOnPageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? ogType = freezed,
    Object? titleHead = freezed,
    Object? descriptionHead = freezed,
    Object? ogImage = freezed,
    Object? ogUrl = freezed,
  }) {
    return _then(_SeoOnPageModel(
      ogType: freezed == ogType
          ? _self.ogType
          : ogType // ignore: cast_nullable_to_non_nullable
              as String?,
      titleHead: freezed == titleHead
          ? _self.titleHead
          : titleHead // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionHead: freezed == descriptionHead
          ? _self.descriptionHead
          : descriptionHead // ignore: cast_nullable_to_non_nullable
              as String?,
      ogImage: freezed == ogImage
          ? _self._ogImage
          : ogImage // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      ogUrl: freezed == ogUrl
          ? _self.ogUrl
          : ogUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$BreadCrumbModel {
  @JsonKey(name: 'name')
  String? get name;
  @JsonKey(name: 'slug')
  String? get slug;
  @JsonKey(name: 'isCurrent')
  bool? get isCurrent;
  @JsonKey(name: 'position')
  int? get position;

  /// Create a copy of BreadCrumbModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BreadCrumbModelCopyWith<BreadCrumbModel> get copyWith =>
      _$BreadCrumbModelCopyWithImpl<BreadCrumbModel>(
          this as BreadCrumbModel, _$identity);

  /// Serializes this BreadCrumbModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BreadCrumbModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, slug, isCurrent, position);

  @override
  String toString() {
    return 'BreadCrumbModel(name: $name, slug: $slug, isCurrent: $isCurrent, position: $position)';
  }
}

/// @nodoc
abstract mixin class $BreadCrumbModelCopyWith<$Res> {
  factory $BreadCrumbModelCopyWith(
          BreadCrumbModel value, $Res Function(BreadCrumbModel) _then) =
      _$BreadCrumbModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'slug') String? slug,
      @JsonKey(name: 'isCurrent') bool? isCurrent,
      @JsonKey(name: 'position') int? position});
}

/// @nodoc
class _$BreadCrumbModelCopyWithImpl<$Res>
    implements $BreadCrumbModelCopyWith<$Res> {
  _$BreadCrumbModelCopyWithImpl(this._self, this._then);

  final BreadCrumbModel _self;
  final $Res Function(BreadCrumbModel) _then;

  /// Create a copy of BreadCrumbModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? slug = freezed,
    Object? isCurrent = freezed,
    Object? position = freezed,
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
      isCurrent: freezed == isCurrent
          ? _self.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool?,
      position: freezed == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _BreadCrumbModel implements BreadCrumbModel {
  const _BreadCrumbModel(
      {@JsonKey(name: 'name') this.name,
      @JsonKey(name: 'slug') this.slug,
      @JsonKey(name: 'isCurrent') this.isCurrent,
      @JsonKey(name: 'position') this.position});
  factory _BreadCrumbModel.fromJson(Map<String, dynamic> json) =>
      _$BreadCrumbModelFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'slug')
  final String? slug;
  @override
  @JsonKey(name: 'isCurrent')
  final bool? isCurrent;
  @override
  @JsonKey(name: 'position')
  final int? position;

  /// Create a copy of BreadCrumbModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BreadCrumbModelCopyWith<_BreadCrumbModel> get copyWith =>
      __$BreadCrumbModelCopyWithImpl<_BreadCrumbModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BreadCrumbModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BreadCrumbModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, slug, isCurrent, position);

  @override
  String toString() {
    return 'BreadCrumbModel(name: $name, slug: $slug, isCurrent: $isCurrent, position: $position)';
  }
}

/// @nodoc
abstract mixin class _$BreadCrumbModelCopyWith<$Res>
    implements $BreadCrumbModelCopyWith<$Res> {
  factory _$BreadCrumbModelCopyWith(
          _BreadCrumbModel value, $Res Function(_BreadCrumbModel) _then) =
      __$BreadCrumbModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'slug') String? slug,
      @JsonKey(name: 'isCurrent') bool? isCurrent,
      @JsonKey(name: 'position') int? position});
}

/// @nodoc
class __$BreadCrumbModelCopyWithImpl<$Res>
    implements _$BreadCrumbModelCopyWith<$Res> {
  __$BreadCrumbModelCopyWithImpl(this._self, this._then);

  final _BreadCrumbModel _self;
  final $Res Function(_BreadCrumbModel) _then;

  /// Create a copy of BreadCrumbModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? slug = freezed,
    Object? isCurrent = freezed,
    Object? position = freezed,
  }) {
    return _then(_BreadCrumbModel(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      isCurrent: freezed == isCurrent
          ? _self.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool?,
      position: freezed == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$StoryItemModel {
  @JsonKey(name: 'name')
  String? get name;
  @JsonKey(name: 'slug')
  String? get slug;
  @JsonKey(name: 'origin_name')
  List<String>? get originName;
  @JsonKey(name: 'status')
  String? get status;
  @JsonKey(name: 'thumb_url')
  String? get thumbUrl;
  @JsonKey(name: 'sub_docquyen')
  bool? get subDocquyen;
  @JsonKey(name: 'category')
  List<CategoryModel>? get category;
  @JsonKey(name: 'updatedAt')
  String? get updatedAt;
  @JsonKey(name: 'chaptersLatest')
  List<ChapterLatestModel>? get chaptersLatest;

  /// Create a copy of StoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StoryItemModelCopyWith<StoryItemModel> get copyWith =>
      _$StoryItemModelCopyWithImpl<StoryItemModel>(
          this as StoryItemModel, _$identity);

  /// Serializes this StoryItemModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StoryItemModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            const DeepCollectionEquality()
                .equals(other.originName, originName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.thumbUrl, thumbUrl) ||
                other.thumbUrl == thumbUrl) &&
            (identical(other.subDocquyen, subDocquyen) ||
                other.subDocquyen == subDocquyen) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other.chaptersLatest, chaptersLatest));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      slug,
      const DeepCollectionEquality().hash(originName),
      status,
      thumbUrl,
      subDocquyen,
      const DeepCollectionEquality().hash(category),
      updatedAt,
      const DeepCollectionEquality().hash(chaptersLatest));

  @override
  String toString() {
    return 'StoryItemModel(name: $name, slug: $slug, originName: $originName, status: $status, thumbUrl: $thumbUrl, subDocquyen: $subDocquyen, category: $category, updatedAt: $updatedAt, chaptersLatest: $chaptersLatest)';
  }
}

/// @nodoc
abstract mixin class $StoryItemModelCopyWith<$Res> {
  factory $StoryItemModelCopyWith(
          StoryItemModel value, $Res Function(StoryItemModel) _then) =
      _$StoryItemModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'slug') String? slug,
      @JsonKey(name: 'origin_name') List<String>? originName,
      @JsonKey(name: 'status') String? status,
      @JsonKey(name: 'thumb_url') String? thumbUrl,
      @JsonKey(name: 'sub_docquyen') bool? subDocquyen,
      @JsonKey(name: 'category') List<CategoryModel>? category,
      @JsonKey(name: 'updatedAt') String? updatedAt,
      @JsonKey(name: 'chaptersLatest')
      List<ChapterLatestModel>? chaptersLatest});
}

/// @nodoc
class _$StoryItemModelCopyWithImpl<$Res>
    implements $StoryItemModelCopyWith<$Res> {
  _$StoryItemModelCopyWithImpl(this._self, this._then);

  final StoryItemModel _self;
  final $Res Function(StoryItemModel) _then;

  /// Create a copy of StoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? slug = freezed,
    Object? originName = freezed,
    Object? status = freezed,
    Object? thumbUrl = freezed,
    Object? subDocquyen = freezed,
    Object? category = freezed,
    Object? updatedAt = freezed,
    Object? chaptersLatest = freezed,
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
      originName: freezed == originName
          ? _self.originName
          : originName // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      chaptersLatest: freezed == chaptersLatest
          ? _self.chaptersLatest
          : chaptersLatest // ignore: cast_nullable_to_non_nullable
              as List<ChapterLatestModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _StoryItemModel implements StoryItemModel {
  const _StoryItemModel(
      {@JsonKey(name: 'name') this.name,
      @JsonKey(name: 'slug') this.slug,
      @JsonKey(name: 'origin_name') final List<String>? originName,
      @JsonKey(name: 'status') this.status,
      @JsonKey(name: 'thumb_url') this.thumbUrl,
      @JsonKey(name: 'sub_docquyen') this.subDocquyen,
      @JsonKey(name: 'category') final List<CategoryModel>? category,
      @JsonKey(name: 'updatedAt') this.updatedAt,
      @JsonKey(name: 'chaptersLatest')
      final List<ChapterLatestModel>? chaptersLatest})
      : _originName = originName,
        _category = category,
        _chaptersLatest = chaptersLatest;
  factory _StoryItemModel.fromJson(Map<String, dynamic> json) =>
      _$StoryItemModelFromJson(json);

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
  @JsonKey(name: 'status')
  final String? status;
  @override
  @JsonKey(name: 'thumb_url')
  final String? thumbUrl;
  @override
  @JsonKey(name: 'sub_docquyen')
  final bool? subDocquyen;
  final List<CategoryModel>? _category;
  @override
  @JsonKey(name: 'category')
  List<CategoryModel>? get category {
    final value = _category;
    if (value == null) return null;
    if (_category is EqualUnmodifiableListView) return _category;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  final List<ChapterLatestModel>? _chaptersLatest;
  @override
  @JsonKey(name: 'chaptersLatest')
  List<ChapterLatestModel>? get chaptersLatest {
    final value = _chaptersLatest;
    if (value == null) return null;
    if (_chaptersLatest is EqualUnmodifiableListView) return _chaptersLatest;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of StoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StoryItemModelCopyWith<_StoryItemModel> get copyWith =>
      __$StoryItemModelCopyWithImpl<_StoryItemModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StoryItemModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StoryItemModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            const DeepCollectionEquality()
                .equals(other._originName, _originName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.thumbUrl, thumbUrl) ||
                other.thumbUrl == thumbUrl) &&
            (identical(other.subDocquyen, subDocquyen) ||
                other.subDocquyen == subDocquyen) &&
            const DeepCollectionEquality().equals(other._category, _category) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other._chaptersLatest, _chaptersLatest));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      slug,
      const DeepCollectionEquality().hash(_originName),
      status,
      thumbUrl,
      subDocquyen,
      const DeepCollectionEquality().hash(_category),
      updatedAt,
      const DeepCollectionEquality().hash(_chaptersLatest));

  @override
  String toString() {
    return 'StoryItemModel(name: $name, slug: $slug, originName: $originName, status: $status, thumbUrl: $thumbUrl, subDocquyen: $subDocquyen, category: $category, updatedAt: $updatedAt, chaptersLatest: $chaptersLatest)';
  }
}

/// @nodoc
abstract mixin class _$StoryItemModelCopyWith<$Res>
    implements $StoryItemModelCopyWith<$Res> {
  factory _$StoryItemModelCopyWith(
          _StoryItemModel value, $Res Function(_StoryItemModel) _then) =
      __$StoryItemModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'slug') String? slug,
      @JsonKey(name: 'origin_name') List<String>? originName,
      @JsonKey(name: 'status') String? status,
      @JsonKey(name: 'thumb_url') String? thumbUrl,
      @JsonKey(name: 'sub_docquyen') bool? subDocquyen,
      @JsonKey(name: 'category') List<CategoryModel>? category,
      @JsonKey(name: 'updatedAt') String? updatedAt,
      @JsonKey(name: 'chaptersLatest')
      List<ChapterLatestModel>? chaptersLatest});
}

/// @nodoc
class __$StoryItemModelCopyWithImpl<$Res>
    implements _$StoryItemModelCopyWith<$Res> {
  __$StoryItemModelCopyWithImpl(this._self, this._then);

  final _StoryItemModel _self;
  final $Res Function(_StoryItemModel) _then;

  /// Create a copy of StoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? slug = freezed,
    Object? originName = freezed,
    Object? status = freezed,
    Object? thumbUrl = freezed,
    Object? subDocquyen = freezed,
    Object? category = freezed,
    Object? updatedAt = freezed,
    Object? chaptersLatest = freezed,
  }) {
    return _then(_StoryItemModel(
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
      category: freezed == category
          ? _self._category
          : category // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      chaptersLatest: freezed == chaptersLatest
          ? _self._chaptersLatest
          : chaptersLatest // ignore: cast_nullable_to_non_nullable
              as List<ChapterLatestModel>?,
    ));
  }
}

/// @nodoc
mixin _$CategoryModel {
  @JsonKey(name: 'id')
  String? get id;
  @JsonKey(name: 'name')
  String? get name;
  @JsonKey(name: 'slug')
  String? get slug;

  /// Create a copy of CategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CategoryModelCopyWith<CategoryModel> get copyWith =>
      _$CategoryModelCopyWithImpl<CategoryModel>(
          this as CategoryModel, _$identity);

  /// Serializes this CategoryModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CategoryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, slug);

  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, slug: $slug)';
  }
}

/// @nodoc
abstract mixin class $CategoryModelCopyWith<$Res> {
  factory $CategoryModelCopyWith(
          CategoryModel value, $Res Function(CategoryModel) _then) =
      _$CategoryModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'slug') String? slug});
}

/// @nodoc
class _$CategoryModelCopyWithImpl<$Res>
    implements $CategoryModelCopyWith<$Res> {
  _$CategoryModelCopyWithImpl(this._self, this._then);

  final CategoryModel _self;
  final $Res Function(CategoryModel) _then;

  /// Create a copy of CategoryModel
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
class _CategoryModel implements CategoryModel {
  const _CategoryModel(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'slug') this.slug});
  factory _CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'slug')
  final String? slug;

  /// Create a copy of CategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CategoryModelCopyWith<_CategoryModel> get copyWith =>
      __$CategoryModelCopyWithImpl<_CategoryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CategoryModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CategoryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, slug);

  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, slug: $slug)';
  }
}

/// @nodoc
abstract mixin class _$CategoryModelCopyWith<$Res>
    implements $CategoryModelCopyWith<$Res> {
  factory _$CategoryModelCopyWith(
          _CategoryModel value, $Res Function(_CategoryModel) _then) =
      __$CategoryModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'slug') String? slug});
}

/// @nodoc
class __$CategoryModelCopyWithImpl<$Res>
    implements _$CategoryModelCopyWith<$Res> {
  __$CategoryModelCopyWithImpl(this._self, this._then);

  final _CategoryModel _self;
  final $Res Function(_CategoryModel) _then;

  /// Create a copy of CategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? slug = freezed,
  }) {
    return _then(_CategoryModel(
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
mixin _$ChapterLatestModel {
  @JsonKey(name: 'filename')
  String? get filename;
  @JsonKey(name: 'chapter_name')
  String? get chapterName;
  @JsonKey(name: 'chapter_title')
  String? get chapterTitle;
  @JsonKey(name: 'chapter_api_data')
  String? get chapterApiData;

  /// Create a copy of ChapterLatestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChapterLatestModelCopyWith<ChapterLatestModel> get copyWith =>
      _$ChapterLatestModelCopyWithImpl<ChapterLatestModel>(
          this as ChapterLatestModel, _$identity);

  /// Serializes this ChapterLatestModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChapterLatestModel &&
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
    return 'ChapterLatestModel(filename: $filename, chapterName: $chapterName, chapterTitle: $chapterTitle, chapterApiData: $chapterApiData)';
  }
}

/// @nodoc
abstract mixin class $ChapterLatestModelCopyWith<$Res> {
  factory $ChapterLatestModelCopyWith(
          ChapterLatestModel value, $Res Function(ChapterLatestModel) _then) =
      _$ChapterLatestModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'filename') String? filename,
      @JsonKey(name: 'chapter_name') String? chapterName,
      @JsonKey(name: 'chapter_title') String? chapterTitle,
      @JsonKey(name: 'chapter_api_data') String? chapterApiData});
}

/// @nodoc
class _$ChapterLatestModelCopyWithImpl<$Res>
    implements $ChapterLatestModelCopyWith<$Res> {
  _$ChapterLatestModelCopyWithImpl(this._self, this._then);

  final ChapterLatestModel _self;
  final $Res Function(ChapterLatestModel) _then;

  /// Create a copy of ChapterLatestModel
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
class _ChapterLatestModel implements ChapterLatestModel {
  const _ChapterLatestModel(
      {@JsonKey(name: 'filename') this.filename,
      @JsonKey(name: 'chapter_name') this.chapterName,
      @JsonKey(name: 'chapter_title') this.chapterTitle,
      @JsonKey(name: 'chapter_api_data') this.chapterApiData});
  factory _ChapterLatestModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterLatestModelFromJson(json);

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

  /// Create a copy of ChapterLatestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChapterLatestModelCopyWith<_ChapterLatestModel> get copyWith =>
      __$ChapterLatestModelCopyWithImpl<_ChapterLatestModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChapterLatestModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChapterLatestModel &&
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
    return 'ChapterLatestModel(filename: $filename, chapterName: $chapterName, chapterTitle: $chapterTitle, chapterApiData: $chapterApiData)';
  }
}

/// @nodoc
abstract mixin class _$ChapterLatestModelCopyWith<$Res>
    implements $ChapterLatestModelCopyWith<$Res> {
  factory _$ChapterLatestModelCopyWith(
          _ChapterLatestModel value, $Res Function(_ChapterLatestModel) _then) =
      __$ChapterLatestModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'filename') String? filename,
      @JsonKey(name: 'chapter_name') String? chapterName,
      @JsonKey(name: 'chapter_title') String? chapterTitle,
      @JsonKey(name: 'chapter_api_data') String? chapterApiData});
}

/// @nodoc
class __$ChapterLatestModelCopyWithImpl<$Res>
    implements _$ChapterLatestModelCopyWith<$Res> {
  __$ChapterLatestModelCopyWithImpl(this._self, this._then);

  final _ChapterLatestModel _self;
  final $Res Function(_ChapterLatestModel) _then;

  /// Create a copy of ChapterLatestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? filename = freezed,
    Object? chapterName = freezed,
    Object? chapterTitle = freezed,
    Object? chapterApiData = freezed,
  }) {
    return _then(_ChapterLatestModel(
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
mixin _$ParamsModel {
  @JsonKey(name: 'type_slug')
  String? get typeSlug;
  @JsonKey(name: 'filterCategory')
  List<String>? get filterCategory;
  @JsonKey(name: 'sortField')
  String? get sortField;
  @JsonKey(name: 'sortType')
  String? get sortType;
  @JsonKey(name: 'pagination')
  PaginationModel? get pagination;

  /// Create a copy of ParamsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ParamsModelCopyWith<ParamsModel> get copyWith =>
      _$ParamsModelCopyWithImpl<ParamsModel>(this as ParamsModel, _$identity);

  /// Serializes this ParamsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParamsModel &&
            (identical(other.typeSlug, typeSlug) ||
                other.typeSlug == typeSlug) &&
            const DeepCollectionEquality()
                .equals(other.filterCategory, filterCategory) &&
            (identical(other.sortField, sortField) ||
                other.sortField == sortField) &&
            (identical(other.sortType, sortType) ||
                other.sortType == sortType) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      typeSlug,
      const DeepCollectionEquality().hash(filterCategory),
      sortField,
      sortType,
      pagination);

  @override
  String toString() {
    return 'ParamsModel(typeSlug: $typeSlug, filterCategory: $filterCategory, sortField: $sortField, sortType: $sortType, pagination: $pagination)';
  }
}

/// @nodoc
abstract mixin class $ParamsModelCopyWith<$Res> {
  factory $ParamsModelCopyWith(
          ParamsModel value, $Res Function(ParamsModel) _then) =
      _$ParamsModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'type_slug') String? typeSlug,
      @JsonKey(name: 'filterCategory') List<String>? filterCategory,
      @JsonKey(name: 'sortField') String? sortField,
      @JsonKey(name: 'sortType') String? sortType,
      @JsonKey(name: 'pagination') PaginationModel? pagination});

  $PaginationModelCopyWith<$Res>? get pagination;
}

/// @nodoc
class _$ParamsModelCopyWithImpl<$Res> implements $ParamsModelCopyWith<$Res> {
  _$ParamsModelCopyWithImpl(this._self, this._then);

  final ParamsModel _self;
  final $Res Function(ParamsModel) _then;

  /// Create a copy of ParamsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typeSlug = freezed,
    Object? filterCategory = freezed,
    Object? sortField = freezed,
    Object? sortType = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_self.copyWith(
      typeSlug: freezed == typeSlug
          ? _self.typeSlug
          : typeSlug // ignore: cast_nullable_to_non_nullable
              as String?,
      filterCategory: freezed == filterCategory
          ? _self.filterCategory
          : filterCategory // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      sortField: freezed == sortField
          ? _self.sortField
          : sortField // ignore: cast_nullable_to_non_nullable
              as String?,
      sortType: freezed == sortType
          ? _self.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as String?,
      pagination: freezed == pagination
          ? _self.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as PaginationModel?,
    ));
  }

  /// Create a copy of ParamsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationModelCopyWith<$Res>? get pagination {
    if (_self.pagination == null) {
      return null;
    }

    return $PaginationModelCopyWith<$Res>(_self.pagination!, (value) {
      return _then(_self.copyWith(pagination: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _ParamsModel implements ParamsModel {
  const _ParamsModel(
      {@JsonKey(name: 'type_slug') this.typeSlug,
      @JsonKey(name: 'filterCategory') final List<String>? filterCategory,
      @JsonKey(name: 'sortField') this.sortField,
      @JsonKey(name: 'sortType') this.sortType,
      @JsonKey(name: 'pagination') this.pagination})
      : _filterCategory = filterCategory;
  factory _ParamsModel.fromJson(Map<String, dynamic> json) =>
      _$ParamsModelFromJson(json);

  @override
  @JsonKey(name: 'type_slug')
  final String? typeSlug;
  final List<String>? _filterCategory;
  @override
  @JsonKey(name: 'filterCategory')
  List<String>? get filterCategory {
    final value = _filterCategory;
    if (value == null) return null;
    if (_filterCategory is EqualUnmodifiableListView) return _filterCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'sortField')
  final String? sortField;
  @override
  @JsonKey(name: 'sortType')
  final String? sortType;
  @override
  @JsonKey(name: 'pagination')
  final PaginationModel? pagination;

  /// Create a copy of ParamsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ParamsModelCopyWith<_ParamsModel> get copyWith =>
      __$ParamsModelCopyWithImpl<_ParamsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ParamsModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ParamsModel &&
            (identical(other.typeSlug, typeSlug) ||
                other.typeSlug == typeSlug) &&
            const DeepCollectionEquality()
                .equals(other._filterCategory, _filterCategory) &&
            (identical(other.sortField, sortField) ||
                other.sortField == sortField) &&
            (identical(other.sortType, sortType) ||
                other.sortType == sortType) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      typeSlug,
      const DeepCollectionEquality().hash(_filterCategory),
      sortField,
      sortType,
      pagination);

  @override
  String toString() {
    return 'ParamsModel(typeSlug: $typeSlug, filterCategory: $filterCategory, sortField: $sortField, sortType: $sortType, pagination: $pagination)';
  }
}

/// @nodoc
abstract mixin class _$ParamsModelCopyWith<$Res>
    implements $ParamsModelCopyWith<$Res> {
  factory _$ParamsModelCopyWith(
          _ParamsModel value, $Res Function(_ParamsModel) _then) =
      __$ParamsModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'type_slug') String? typeSlug,
      @JsonKey(name: 'filterCategory') List<String>? filterCategory,
      @JsonKey(name: 'sortField') String? sortField,
      @JsonKey(name: 'sortType') String? sortType,
      @JsonKey(name: 'pagination') PaginationModel? pagination});

  @override
  $PaginationModelCopyWith<$Res>? get pagination;
}

/// @nodoc
class __$ParamsModelCopyWithImpl<$Res> implements _$ParamsModelCopyWith<$Res> {
  __$ParamsModelCopyWithImpl(this._self, this._then);

  final _ParamsModel _self;
  final $Res Function(_ParamsModel) _then;

  /// Create a copy of ParamsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? typeSlug = freezed,
    Object? filterCategory = freezed,
    Object? sortField = freezed,
    Object? sortType = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_ParamsModel(
      typeSlug: freezed == typeSlug
          ? _self.typeSlug
          : typeSlug // ignore: cast_nullable_to_non_nullable
              as String?,
      filterCategory: freezed == filterCategory
          ? _self._filterCategory
          : filterCategory // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      sortField: freezed == sortField
          ? _self.sortField
          : sortField // ignore: cast_nullable_to_non_nullable
              as String?,
      sortType: freezed == sortType
          ? _self.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as String?,
      pagination: freezed == pagination
          ? _self.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as PaginationModel?,
    ));
  }

  /// Create a copy of ParamsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationModelCopyWith<$Res>? get pagination {
    if (_self.pagination == null) {
      return null;
    }

    return $PaginationModelCopyWith<$Res>(_self.pagination!, (value) {
      return _then(_self.copyWith(pagination: value));
    });
  }
}

/// @nodoc
mixin _$PaginationModel {
  @JsonKey(name: 'totalItems')
  int? get totalItems;
  @JsonKey(name: 'totalItemsPerPage')
  int? get totalItemsPerPage;
  @JsonKey(name: 'currentPage')
  int? get currentPage;
  @JsonKey(name: 'pageRanges')
  int? get pageRanges;

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaginationModelCopyWith<PaginationModel> get copyWith =>
      _$PaginationModelCopyWithImpl<PaginationModel>(
          this as PaginationModel, _$identity);

  /// Serializes this PaginationModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PaginationModel &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.totalItemsPerPage, totalItemsPerPage) ||
                other.totalItemsPerPage == totalItemsPerPage) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.pageRanges, pageRanges) ||
                other.pageRanges == pageRanges));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, totalItems, totalItemsPerPage, currentPage, pageRanges);

  @override
  String toString() {
    return 'PaginationModel(totalItems: $totalItems, totalItemsPerPage: $totalItemsPerPage, currentPage: $currentPage, pageRanges: $pageRanges)';
  }
}

/// @nodoc
abstract mixin class $PaginationModelCopyWith<$Res> {
  factory $PaginationModelCopyWith(
          PaginationModel value, $Res Function(PaginationModel) _then) =
      _$PaginationModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'totalItems') int? totalItems,
      @JsonKey(name: 'totalItemsPerPage') int? totalItemsPerPage,
      @JsonKey(name: 'currentPage') int? currentPage,
      @JsonKey(name: 'pageRanges') int? pageRanges});
}

/// @nodoc
class _$PaginationModelCopyWithImpl<$Res>
    implements $PaginationModelCopyWith<$Res> {
  _$PaginationModelCopyWithImpl(this._self, this._then);

  final PaginationModel _self;
  final $Res Function(PaginationModel) _then;

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalItems = freezed,
    Object? totalItemsPerPage = freezed,
    Object? currentPage = freezed,
    Object? pageRanges = freezed,
  }) {
    return _then(_self.copyWith(
      totalItems: freezed == totalItems
          ? _self.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int?,
      totalItemsPerPage: freezed == totalItemsPerPage
          ? _self.totalItemsPerPage
          : totalItemsPerPage // ignore: cast_nullable_to_non_nullable
              as int?,
      currentPage: freezed == currentPage
          ? _self.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
      pageRanges: freezed == pageRanges
          ? _self.pageRanges
          : pageRanges // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PaginationModel implements PaginationModel {
  const _PaginationModel(
      {@JsonKey(name: 'totalItems') this.totalItems,
      @JsonKey(name: 'totalItemsPerPage') this.totalItemsPerPage,
      @JsonKey(name: 'currentPage') this.currentPage,
      @JsonKey(name: 'pageRanges') this.pageRanges});
  factory _PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);

  @override
  @JsonKey(name: 'totalItems')
  final int? totalItems;
  @override
  @JsonKey(name: 'totalItemsPerPage')
  final int? totalItemsPerPage;
  @override
  @JsonKey(name: 'currentPage')
  final int? currentPage;
  @override
  @JsonKey(name: 'pageRanges')
  final int? pageRanges;

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaginationModelCopyWith<_PaginationModel> get copyWith =>
      __$PaginationModelCopyWithImpl<_PaginationModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PaginationModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaginationModel &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.totalItemsPerPage, totalItemsPerPage) ||
                other.totalItemsPerPage == totalItemsPerPage) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.pageRanges, pageRanges) ||
                other.pageRanges == pageRanges));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, totalItems, totalItemsPerPage, currentPage, pageRanges);

  @override
  String toString() {
    return 'PaginationModel(totalItems: $totalItems, totalItemsPerPage: $totalItemsPerPage, currentPage: $currentPage, pageRanges: $pageRanges)';
  }
}

/// @nodoc
abstract mixin class _$PaginationModelCopyWith<$Res>
    implements $PaginationModelCopyWith<$Res> {
  factory _$PaginationModelCopyWith(
          _PaginationModel value, $Res Function(_PaginationModel) _then) =
      __$PaginationModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'totalItems') int? totalItems,
      @JsonKey(name: 'totalItemsPerPage') int? totalItemsPerPage,
      @JsonKey(name: 'currentPage') int? currentPage,
      @JsonKey(name: 'pageRanges') int? pageRanges});
}

/// @nodoc
class __$PaginationModelCopyWithImpl<$Res>
    implements _$PaginationModelCopyWith<$Res> {
  __$PaginationModelCopyWithImpl(this._self, this._then);

  final _PaginationModel _self;
  final $Res Function(_PaginationModel) _then;

  /// Create a copy of PaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalItems = freezed,
    Object? totalItemsPerPage = freezed,
    Object? currentPage = freezed,
    Object? pageRanges = freezed,
  }) {
    return _then(_PaginationModel(
      totalItems: freezed == totalItems
          ? _self.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int?,
      totalItemsPerPage: freezed == totalItemsPerPage
          ? _self.totalItemsPerPage
          : totalItemsPerPage // ignore: cast_nullable_to_non_nullable
              as int?,
      currentPage: freezed == currentPage
          ? _self.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
      pageRanges: freezed == pageRanges
          ? _self.pageRanges
          : pageRanges // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
