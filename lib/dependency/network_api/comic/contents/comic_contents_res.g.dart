// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_contents_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ComicContentsRes _$ComicContentsResFromJson(Map<String, dynamic> json) =>
    _ComicContentsRes(
      domainCdn: json['domain_cdn'] as String?,
      item: json['item'] == null
          ? null
          : ComicChapterItemModel.fromJson(
              json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComicContentsResToJson(_ComicContentsRes instance) =>
    <String, dynamic>{
      'domain_cdn': instance.domainCdn,
      'item': instance.item,
    };

_ComicChapterItemModel _$ComicChapterItemModelFromJson(
        Map<String, dynamic> json) =>
    _ComicChapterItemModel(
      id: json['_id'] as String?,
      comicName: json['comic_name'] as String?,
      chapterName: json['chapter_name'] as String?,
      chapterTitle: json['chapter_title'] as String?,
      chapterPath: json['chapter_path'] as String?,
      chapterImage: (json['chapter_image'] as List<dynamic>?)
          ?.map((e) => ComicImagePageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComicChapterItemModelToJson(
        _ComicChapterItemModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'comic_name': instance.comicName,
      'chapter_name': instance.chapterName,
      'chapter_title': instance.chapterTitle,
      'chapter_path': instance.chapterPath,
      'chapter_image': instance.chapterImage,
    };

_ComicImagePageModel _$ComicImagePageModelFromJson(Map<String, dynamic> json) =>
    _ComicImagePageModel(
      imagePage: (json['image_page'] as num?)?.toInt(),
      imageFile: json['image_file'] as String?,
    );

Map<String, dynamic> _$ComicImagePageModelToJson(
        _ComicImagePageModel instance) =>
    <String, dynamic>{
      'image_page': instance.imagePage,
      'image_file': instance.imageFile,
    };
