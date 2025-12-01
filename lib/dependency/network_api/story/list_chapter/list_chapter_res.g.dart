// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_chapter_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListChapterRes _$ListChapterResFromJson(Map<String, dynamic> json) =>
    _ListChapterRes(
      id: json['ID'] as String?,
      order: json['ORDER'] as String?,
      name: json['NAME'] as String?,
      url: json['URL'] as String?,
      user: json['USER'] as String?,
      userUrl: json['USERURL'] as String?,
      date: json['DATE'] as String?,
      count: (json['COUNT'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ListChapterResToJson(_ListChapterRes instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'ORDER': instance.order,
      'NAME': instance.name,
      'URL': instance.url,
      'USER': instance.user,
      'USERURL': instance.userUrl,
      'DATE': instance.date,
      'COUNT': instance.count,
    };
