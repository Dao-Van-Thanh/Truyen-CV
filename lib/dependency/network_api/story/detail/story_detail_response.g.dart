// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoryDetailResponse _$StoryDetailResponseFromJson(Map<String, dynamic> json) =>
    _StoryDetailResponse(
      id: json['ID'] as String?,
      name: json['NAME'] as String?,
      chapter: (json['CHAPTER'] as List<dynamic>?)
          ?.map((e) => ChapterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalChapter: json['TOTALCHAPTER'] as String?,
      img: json['IMG'] as String?,
      category: json['CAT'] as String?,
      author: json['AUTHOR'] as String?,
      translator: json['TRANS'] as String?,
      description: json['DESC'] as String?,
      thumb: json['THUMB'] as String?,
    );

Map<String, dynamic> _$StoryDetailResponseToJson(
        _StoryDetailResponse instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'NAME': instance.name,
      'CHAPTER': instance.chapter,
      'TOTALCHAPTER': instance.totalChapter,
      'IMG': instance.img,
      'CAT': instance.category,
      'AUTHOR': instance.author,
      'TRANS': instance.translator,
      'DESC': instance.description,
      'THUMB': instance.thumb,
    };

_ChapterModel _$ChapterModelFromJson(Map<String, dynamic> json) =>
    _ChapterModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ChapterModelToJson(_ChapterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
