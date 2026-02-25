import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_chapter_res.freezed.dart';
part 'list_chapter_res.g.dart';

@freezed
abstract class ListChapterRes with _$ListChapterRes {
  const factory ListChapterRes({
    @JsonKey(name: 'ID') String? id,
    @JsonKey(name: 'ORDER') String? order,
    @JsonKey(name: 'NAME') String? name,
    @JsonKey(name: 'URL') String? url,
    @JsonKey(name: 'USER') String? user,
    @JsonKey(name: 'USERURL') String? userUrl,
    @JsonKey(name: 'DATE') String? date,
    @JsonKey(name: 'COUNT') int? count,
  }) = _ListChapterRes;

  factory ListChapterRes.fromJson(Map<String, dynamic> json) =>
      _$ListChapterResFromJson(json);
}
