import 'package:flutter_template/dependency/local_api/repository/book/enum/story_type.dart';
import 'package:flutter_template/features/story/detail/entities/story_detail_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_detail_response.freezed.dart';
part 'story_detail_response.g.dart';

@freezed
abstract class StoryDetailResponse with _$StoryDetailResponse {
  const factory StoryDetailResponse({
    @JsonKey(name: 'ID') String? id,
    @JsonKey(name: 'NAME') String? name,
    @JsonKey(name: 'CHAPTER') List<ChapterModel>? chapter,
    @JsonKey(name: 'TOTALCHAPTER') String? totalChapter,
    @JsonKey(name: 'IMG') String? img,
    @JsonKey(name: 'CAT') String? category,
    @JsonKey(name: 'AUTHOR') String? author,
    @JsonKey(name: 'TRANS') String? translator,
    @JsonKey(name: 'DESC') String? description,
    @JsonKey(name: 'THUMB') String? thumb,
  }) = _StoryDetailResponse;

  factory StoryDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryDetailResponseFromJson(json);
}

@freezed
abstract class ChapterModel with _$ChapterModel {
  const factory ChapterModel({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'name') String? name,
  }) = _ChapterModel;

  factory ChapterModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterModelFromJson(json);
}

extension StoryDetailResponseExtension on StoryDetailResponse {
  StoryDetailEntity toEntity() {
    return StoryDetailEntity(
      id: id ?? '',
      name: name ?? '',
      totalChapter: totalChapter ?? '',
      cat: category,
      author: author,
      trans: translator,
      desc: description ?? '',
      thumb: thumb ?? '',
      type: StoryType.novel,
      listChapter: [],
    );
  }
}
