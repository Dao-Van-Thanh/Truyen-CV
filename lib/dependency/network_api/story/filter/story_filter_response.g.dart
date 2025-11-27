// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_filter_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoryFilterResponse _$StoryFilterResponseFromJson(Map<String, dynamic> json) =>
    _StoryFilterResponse(
      success: (json['success'] as num?)?.toInt(),
      pager: json['pager'] == null
          ? null
          : PagerModel.fromJson(json['pager'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoryFilterResponseToJson(
        _StoryFilterResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'pager': instance.pager,
      'data': instance.data,
    };

_PagerModel _$PagerModelFromJson(Map<String, dynamic> json) => _PagerModel(
      page: (json['page'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
      totalCount: json['total_count'] as String?,
    );

Map<String, dynamic> _$PagerModelToJson(_PagerModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'total_count': instance.totalCount,
    };

_StoryModel _$StoryModelFromJson(Map<String, dynamic> json) => _StoryModel(
      id: json['ID'] as String?,
      name: json['NAME'] as String?,
      thumb: json['THUMB'] as String?,
      process: json['PROCESS'] as String?,
      author: json['AUTHOR'] as String?,
      viewed: json['VIEWED'] as String?,
      rating: (json['RATING'] as num?)?.toDouble(),
      count: (json['COUNT'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StoryModelToJson(_StoryModel instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'NAME': instance.name,
      'THUMB': instance.thumb,
      'PROCESS': instance.process,
      'AUTHOR': instance.author,
      'VIEWED': instance.viewed,
      'RATING': instance.rating,
      'COUNT': instance.count,
    };
