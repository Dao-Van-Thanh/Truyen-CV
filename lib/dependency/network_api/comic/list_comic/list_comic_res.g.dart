// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_comic_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListComicRes _$ListComicResFromJson(Map<String, dynamic> json) =>
    _ListComicRes(
      seoOnPage: json['seoOnPage'] == null
          ? null
          : SeoOnPageModel.fromJson(json['seoOnPage'] as Map<String, dynamic>),
      breadCrumb: (json['breadCrumb'] as List<dynamic>?)
          ?.map((e) => BreadCrumbModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      titlePage: json['titlePage'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => StoryItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      params: json['params'] == null
          ? null
          : ParamsModel.fromJson(json['params'] as Map<String, dynamic>),
      typeList: json['type_list'] as String?,
      appDomainFrontend: json['APP_DOMAIN_FRONTEND'] as String?,
      appDomainCdnImage: json['APP_DOMAIN_CDN_IMAGE'] as String?,
    );

Map<String, dynamic> _$ListComicResToJson(_ListComicRes instance) =>
    <String, dynamic>{
      'seoOnPage': instance.seoOnPage,
      'breadCrumb': instance.breadCrumb,
      'titlePage': instance.titlePage,
      'items': instance.items,
      'params': instance.params,
      'type_list': instance.typeList,
      'APP_DOMAIN_FRONTEND': instance.appDomainFrontend,
      'APP_DOMAIN_CDN_IMAGE': instance.appDomainCdnImage,
    };

_SeoOnPageModel _$SeoOnPageModelFromJson(Map<String, dynamic> json) =>
    _SeoOnPageModel(
      ogType: json['og_type'] as String?,
      titleHead: json['titleHead'] as String?,
      descriptionHead: json['descriptionHead'] as String?,
      ogImage: (json['og_image'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      ogUrl: json['og_url'] as String?,
    );

Map<String, dynamic> _$SeoOnPageModelToJson(_SeoOnPageModel instance) =>
    <String, dynamic>{
      'og_type': instance.ogType,
      'titleHead': instance.titleHead,
      'descriptionHead': instance.descriptionHead,
      'og_image': instance.ogImage,
      'og_url': instance.ogUrl,
    };

_BreadCrumbModel _$BreadCrumbModelFromJson(Map<String, dynamic> json) =>
    _BreadCrumbModel(
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      isCurrent: json['isCurrent'] as bool?,
      position: (json['position'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BreadCrumbModelToJson(_BreadCrumbModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'slug': instance.slug,
      'isCurrent': instance.isCurrent,
      'position': instance.position,
    };

_StoryItemModel _$StoryItemModelFromJson(Map<String, dynamic> json) =>
    _StoryItemModel(
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      originName: (json['origin_name'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: json['status'] as String?,
      thumbUrl: json['thumb_url'] as String?,
      subDocquyen: json['sub_docquyen'] as bool?,
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      updatedAt: json['updatedAt'] as String?,
      chaptersLatest: (json['chaptersLatest'] as List<dynamic>?)
          ?.map((e) => ChapterLatestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoryItemModelToJson(_StoryItemModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'slug': instance.slug,
      'origin_name': instance.originName,
      'status': instance.status,
      'thumb_url': instance.thumbUrl,
      'sub_docquyen': instance.subDocquyen,
      'category': instance.category,
      'updatedAt': instance.updatedAt,
      'chaptersLatest': instance.chaptersLatest,
    };

_CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    _CategoryModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(_CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
    };

_ChapterLatestModel _$ChapterLatestModelFromJson(Map<String, dynamic> json) =>
    _ChapterLatestModel(
      filename: json['filename'] as String?,
      chapterName: json['chapter_name'] as String?,
      chapterTitle: json['chapter_title'] as String?,
      chapterApiData: json['chapter_api_data'] as String?,
    );

Map<String, dynamic> _$ChapterLatestModelToJson(_ChapterLatestModel instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'chapter_name': instance.chapterName,
      'chapter_title': instance.chapterTitle,
      'chapter_api_data': instance.chapterApiData,
    };

_ParamsModel _$ParamsModelFromJson(Map<String, dynamic> json) => _ParamsModel(
      typeSlug: json['type_slug'] as String?,
      filterCategory: (json['filterCategory'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sortField: json['sortField'] as String?,
      sortType: json['sortType'] as String?,
      pagination: json['pagination'] == null
          ? null
          : PaginationModel.fromJson(
              json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ParamsModelToJson(_ParamsModel instance) =>
    <String, dynamic>{
      'type_slug': instance.typeSlug,
      'filterCategory': instance.filterCategory,
      'sortField': instance.sortField,
      'sortType': instance.sortType,
      'pagination': instance.pagination,
    };

_PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) =>
    _PaginationModel(
      totalItems: (json['totalItems'] as num?)?.toInt(),
      totalItemsPerPage: (json['totalItemsPerPage'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
      pageRanges: (json['pageRanges'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationModelToJson(_PaginationModel instance) =>
    <String, dynamic>{
      'totalItems': instance.totalItems,
      'totalItemsPerPage': instance.totalItemsPerPage,
      'currentPage': instance.currentPage,
      'pageRanges': instance.pageRanges,
    };
