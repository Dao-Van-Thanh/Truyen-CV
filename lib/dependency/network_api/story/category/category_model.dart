import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
abstract class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    @JsonKey(name: 'ID') String? id,
    @JsonKey(name: 'NAME') String? name,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}

// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'get_category_response.freezed.dart';
// part 'get_category_response.g.dart';

// @freezed
// abstract class GetCategoryResponse with _$GetCategoryResponse {
//   const factory GetCategoryResponse({
//     @JsonKey(name: 'ID') String? id,
//     @JsonKey(name: 'NAME') String? name,
//     @JsonKey(name: 'CHAPTER') List<ChapterModel>? chapter,
//     @JsonKey(name: 'TOTALCHAPTER') String? totalChapter,
//     @JsonKey(name: 'IMG') String? img,
//     @JsonKey(name: 'CAT') String? category,
//     @JsonKey(name: 'AUTHOR') String? author,
//     @JsonKey(name: 'TRANS') String? translator,
//     @JsonKey(name: 'DESC') String? description,
//     @JsonKey(name: 'THUMB') String? thumb,
//   }) = _GetCategoryResponse;

//   factory GetCategoryResponse.fromJson(Map<String, dynamic> json) =>
//       _$GetCategoryResponseFromJson(json);
// }

// @freezed
// abstract class ChapterModel with _$ChapterModel {
//   const factory ChapterModel({
//     @JsonKey(name: 'id') String? id,
//     @JsonKey(name: 'name') String? name,
//   }) = _ChapterModel;

//   factory ChapterModel.fromJson(Map<String, dynamic> json) =>
//       _$ChapterModelFromJson(json);
// }
