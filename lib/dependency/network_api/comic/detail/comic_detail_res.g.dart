// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_detail_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ComicDetailRes _$ComicDetailResFromJson(Map<String, dynamic> json) =>
    _ComicDetailRes(
      seoOnPage: json['seoOnPage'] == null
          ? null
          : ComicSeoOnPage.fromJson(json['seoOnPage'] as Map<String, dynamic>),
      breadCrumb: (json['breadCrumb'] as List<dynamic>?)
          ?.map((e) => ComicBreadCrumb.fromJson(e as Map<String, dynamic>))
          .toList(),
      params: json['params'] == null
          ? null
          : ComicParams.fromJson(json['params'] as Map<String, dynamic>),
      item: json['item'] == null
          ? null
          : ComicItem.fromJson(json['item'] as Map<String, dynamic>),
      appDomainCdnImage: json['APP_DOMAIN_CDN_IMAGE'] as String?,
    );

Map<String, dynamic> _$ComicDetailResToJson(_ComicDetailRes instance) =>
    <String, dynamic>{
      'seoOnPage': instance.seoOnPage?.toJson(),
      'breadCrumb': instance.breadCrumb?.map((e) => e.toJson()).toList(),
      'params': instance.params?.toJson(),
      'item': instance.item?.toJson(),
      'APP_DOMAIN_CDN_IMAGE': instance.appDomainCdnImage,
    };

_ComicSeoOnPage _$ComicSeoOnPageFromJson(Map<String, dynamic> json) =>
    _ComicSeoOnPage(
      ogType: json['og_type'] as String?,
      titleHead: json['titleHead'] as String?,
      seoSchema: json['seoSchema'] == null
          ? null
          : ComicSeoSchema.fromJson(json['seoSchema'] as Map<String, dynamic>),
      descriptionHead: json['descriptionHead'] as String?,
      ogImage: (json['og_image'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      updatedTime: (json['updated_time'] as num?)?.toInt(),
      ogUrl: json['og_url'] as String?,
    );

Map<String, dynamic> _$ComicSeoOnPageToJson(_ComicSeoOnPage instance) =>
    <String, dynamic>{
      'og_type': instance.ogType,
      'titleHead': instance.titleHead,
      'seoSchema': instance.seoSchema?.toJson(),
      'descriptionHead': instance.descriptionHead,
      'og_image': instance.ogImage,
      'updated_time': instance.updatedTime,
      'og_url': instance.ogUrl,
    };

_ComicSeoSchema _$ComicSeoSchemaFromJson(Map<String, dynamic> json) =>
    _ComicSeoSchema(
      context: json['@context'] as String?,
      type: json['@type'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      image: json['image'] as String?,
      director: json['director'] as String?,
    );

Map<String, dynamic> _$ComicSeoSchemaToJson(_ComicSeoSchema instance) =>
    <String, dynamic>{
      '@context': instance.context,
      '@type': instance.type,
      'name': instance.name,
      'url': instance.url,
      'image': instance.image,
      'director': instance.director,
    };

_ComicBreadCrumb _$ComicBreadCrumbFromJson(Map<String, dynamic> json) =>
    _ComicBreadCrumb(
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      position: (json['position'] as num?)?.toInt(),
      isCurrent: json['isCurrent'] as bool?,
    );

Map<String, dynamic> _$ComicBreadCrumbToJson(_ComicBreadCrumb instance) =>
    <String, dynamic>{
      'name': instance.name,
      'slug': instance.slug,
      'position': instance.position,
      'isCurrent': instance.isCurrent,
    };

_ComicParams _$ComicParamsFromJson(Map<String, dynamic> json) => _ComicParams(
      slug: json['slug'] as String?,
      crawlCheckUrl: json['crawl_check_url'] as String?,
    );

Map<String, dynamic> _$ComicParamsToJson(_ComicParams instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'crawl_check_url': instance.crawlCheckUrl,
    };

_ComicItem _$ComicItemFromJson(Map<String, dynamic> json) => _ComicItem(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      originName: (json['origin_name'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      content: json['content'] as String?,
      status: json['status'] as String?,
      thumbUrl: json['thumb_url'] as String?,
      subDocquyen: json['sub_docquyen'] as bool?,
      author:
          (json['author'] as List<dynamic>?)?.map((e) => e as String).toList(),
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => ComicCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      chapters: (json['chapters'] as List<dynamic>?)
          ?.map((e) => ComicChapterServer.fromJson(e as Map<String, dynamic>))
          .toList(),
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ComicItemToJson(_ComicItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'origin_name': instance.originName,
      'content': instance.content,
      'status': instance.status,
      'thumb_url': instance.thumbUrl,
      'sub_docquyen': instance.subDocquyen,
      'author': instance.author,
      'category': instance.category?.map((e) => e.toJson()).toList(),
      'chapters': instance.chapters?.map((e) => e.toJson()).toList(),
      'updatedAt': instance.updatedAt,
    };

_ComicCategory _$ComicCategoryFromJson(Map<String, dynamic> json) =>
    _ComicCategory(
      id: json['id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$ComicCategoryToJson(_ComicCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
    };

_ComicChapterServer _$ComicChapterServerFromJson(Map<String, dynamic> json) =>
    _ComicChapterServer(
      serverName: json['server_name'] as String?,
      serverData: (json['server_data'] as List<dynamic>?)
          ?.map((e) => ComicChapter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComicChapterServerToJson(_ComicChapterServer instance) =>
    <String, dynamic>{
      'server_name': instance.serverName,
      'server_data': instance.serverData?.map((e) => e.toJson()).toList(),
    };

_ComicChapter _$ComicChapterFromJson(Map<String, dynamic> json) =>
    _ComicChapter(
      filename: json['filename'] as String?,
      chapterName: json['chapter_name'] as String?,
      chapterTitle: json['chapter_title'] as String?,
      chapterApiData: json['chapter_api_data'] as String?,
    );

Map<String, dynamic> _$ComicChapterToJson(_ComicChapter instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'chapter_name': instance.chapterName,
      'chapter_title': instance.chapterTitle,
      'chapter_api_data': instance.chapterApiData,
    };
