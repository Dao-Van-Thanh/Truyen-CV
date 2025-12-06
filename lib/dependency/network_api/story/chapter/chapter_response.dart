import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter_response.freezed.dart';
part 'chapter_response.g.dart';

@freezed
abstract class ChapterResponse with _$ChapterResponse {
  const factory ChapterResponse({
    @JsonKey(name: 'EID') String? eid,
    @JsonKey(name: 'ID') String? id,
    @JsonKey(name: 'ORDER') String? order,
    @JsonKey(name: 'CONTENT') String? content,
    @JsonKey(name: 'NAME') String? name,
    @JsonKey(name: 'ENAME') String? ename,
    @JsonKey(name: 'PREV') String? prev,
    @JsonKey(name: 'NEXT') String? next,
    @JsonKey(name: 'UNAME') String? uname,
  }) = _ChapterResponse;

  factory ChapterResponse.fromJson(Map<String, dynamic> json) =>
      _$ChapterResponseFromJson(json);
}
