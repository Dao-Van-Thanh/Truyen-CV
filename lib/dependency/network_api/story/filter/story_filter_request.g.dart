// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_filter_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoryFilterRequest _$StoryFilterRequestFromJson(Map<String, dynamic> json) =>
    _StoryFilterRequest(
      status: (json['status'] as num?)?.toInt() ?? 0,
      cat: (json['cat'] as num?)?.toInt() ?? 0,
      page: (json['page'] as num?)?.toInt() ?? 1,
      sort: (json['sort'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$StoryFilterRequestToJson(_StoryFilterRequest instance) =>
    <String, dynamic>{
      'status': instance.status,
      'cat': instance.cat,
      'page': instance.page,
      'sort': instance.sort,
    };
