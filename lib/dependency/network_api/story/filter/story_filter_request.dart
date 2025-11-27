import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_filter_request.freezed.dart';
part 'story_filter_request.g.dart';

@freezed
abstract class StoryFilterRequest with _$StoryFilterRequest {
  const factory StoryFilterRequest({
    @Default(0) int status,
    @Default(0) int cat,
    @Default(1) int page,
    @Default(0) int sort,
  }) = _StoryFilterRequest;

  factory StoryFilterRequest.fromJson(Map<String, dynamic> json) =>
      _$StoryFilterRequestFromJson(json);
}
