import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_filter_response.freezed.dart';
part 'story_filter_response.g.dart';

@freezed
abstract class StoryFilterResponse with _$StoryFilterResponse {
  const factory StoryFilterResponse({
    int? success,
    PagerModel? pager,
    List<StoryModel>? data,
  }) = _StoryFilterResponse;

  factory StoryFilterResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryFilterResponseFromJson(json);
}

@freezed
abstract class PagerModel with _$PagerModel {
  const factory PagerModel({
    int? page,
    int? size,
    @JsonKey(name: 'total_count') String? totalCount,
  }) = _PagerModel;

  factory PagerModel.fromJson(Map<String, dynamic> json) =>
      _$PagerModelFromJson(json);
}

@freezed
abstract class StoryModel with _$StoryModel {
  const factory StoryModel({
    @JsonKey(name: 'ID') String? id,
    @JsonKey(name: 'NAME') String? name,
    @JsonKey(name: 'THUMB') String? thumb,
    @JsonKey(name: 'PROCESS') String? process,
    @JsonKey(name: 'AUTHOR') String? author,
    @JsonKey(name: 'VIEWED') String? viewed,
    @JsonKey(name: 'RATING') double? rating,
    @JsonKey(name: 'COUNT') int? count,
  }) = _StoryModel;

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);
}
