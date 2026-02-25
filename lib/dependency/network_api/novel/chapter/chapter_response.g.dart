// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChapterResponse _$ChapterResponseFromJson(Map<String, dynamic> json) =>
    _ChapterResponse(
      eid: json['EID'] as String?,
      id: json['ID'] as String?,
      order: json['ORDER'] as String?,
      content: json['CONTENT'] as String?,
      name: json['NAME'] as String?,
      ename: json['ENAME'] as String?,
      prev: json['PREV'] as String?,
      next: json['NEXT'] as String?,
      uname: json['UNAME'] as String?,
    );

Map<String, dynamic> _$ChapterResponseToJson(_ChapterResponse instance) =>
    <String, dynamic>{
      'EID': instance.eid,
      'ID': instance.id,
      'ORDER': instance.order,
      'CONTENT': instance.content,
      'NAME': instance.name,
      'ENAME': instance.ename,
      'PREV': instance.prev,
      'NEXT': instance.next,
      'UNAME': instance.uname,
    };
