import 'package:truyen_cv/dependency/local_api/repository/book/entities/story_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_comic_res.freezed.dart';
part 'list_comic_res.g.dart';

@freezed
abstract class ListComicRes with _$ListComicRes {
  const factory ListComicRes({
    @JsonKey(name: 'seoOnPage') SeoOnPageModel? seoOnPage,
    @JsonKey(name: 'breadCrumb') List<BreadCrumbModel>? breadCrumb,
    @JsonKey(name: 'titlePage') String? titlePage,
    @JsonKey(name: 'items') List<StoryItemModel>? items,
    @JsonKey(name: 'params') ParamsModel? params,
    @JsonKey(name: 'type_list') String? typeList,
    @JsonKey(name: 'APP_DOMAIN_FRONTEND') String? appDomainFrontend,
    @JsonKey(name: 'APP_DOMAIN_CDN_IMAGE') String? appDomainCdnImage,
  }) = _ListComicRes;

  factory ListComicRes.fromJson(Map<String, dynamic> json) =>
      _$ListComicResFromJson(json);
}

@freezed
abstract class SeoOnPageModel with _$SeoOnPageModel {
  const factory SeoOnPageModel({
    @JsonKey(name: 'og_type') String? ogType,
    @JsonKey(name: 'titleHead') String? titleHead,
    @JsonKey(name: 'descriptionHead') String? descriptionHead,
    @JsonKey(name: 'og_image') List<String>? ogImage,
    @JsonKey(name: 'og_url') String? ogUrl,
  }) = _SeoOnPageModel;

  factory SeoOnPageModel.fromJson(Map<String, dynamic> json) =>
      _$SeoOnPageModelFromJson(json);
}

@freezed
abstract class BreadCrumbModel with _$BreadCrumbModel {
  const factory BreadCrumbModel({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'isCurrent') bool? isCurrent,
    @JsonKey(name: 'position') int? position,
  }) = _BreadCrumbModel;

  factory BreadCrumbModel.fromJson(Map<String, dynamic> json) =>
      _$BreadCrumbModelFromJson(json);
}

@freezed
abstract class StoryItemModel with _$StoryItemModel {
  const factory StoryItemModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'origin_name') List<String>? originName,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'thumb_url') String? thumbUrl,
    @JsonKey(name: 'sub_docquyen') bool? subDocquyen,
    @JsonKey(name: 'category') List<CategoryModel>? category,
    @JsonKey(name: 'updatedAt') String? updatedAt,
    @JsonKey(name: 'chaptersLatest') List<ChapterLatestModel>? chaptersLatest,
  }) = _StoryItemModel;

  factory StoryItemModel.fromJson(Map<String, dynamic> json) =>
      _$StoryItemModelFromJson(json);
}

@freezed
abstract class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'slug') String? slug,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}

@freezed
abstract class ChapterLatestModel with _$ChapterLatestModel {
  const factory ChapterLatestModel({
    @JsonKey(name: 'filename') String? filename,
    @JsonKey(name: 'chapter_name') String? chapterName,
    @JsonKey(name: 'chapter_title') String? chapterTitle,
    @JsonKey(name: 'chapter_api_data') String? chapterApiData,
  }) = _ChapterLatestModel;

  factory ChapterLatestModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterLatestModelFromJson(json);
}

@freezed
abstract class ParamsModel with _$ParamsModel {
  const factory ParamsModel({
    @JsonKey(name: 'type_slug') String? typeSlug,
    @JsonKey(name: 'filterCategory') List<String>? filterCategory,
    @JsonKey(name: 'sortField') String? sortField,
    @JsonKey(name: 'sortType') String? sortType,
    @JsonKey(name: 'pagination') PaginationModel? pagination,
  }) = _ParamsModel;

  factory ParamsModel.fromJson(Map<String, dynamic> json) =>
      _$ParamsModelFromJson(json);
}

@freezed
abstract class PaginationModel with _$PaginationModel {
  const factory PaginationModel({
    @JsonKey(name: 'totalItems') int? totalItems,
    @JsonKey(name: 'totalItemsPerPage') int? totalItemsPerPage,
    @JsonKey(name: 'currentPage') int? currentPage,
    @JsonKey(name: 'pageRanges') int? pageRanges,
  }) = _PaginationModel;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);
}

extension StoryItemModelExtension on StoryItemModel {
  String get fullId => '${id ?? '-1'}||${slug ?? '-1'}';
}

extension ListComicResExtension on ListComicRes {
  List<StoryEntity> toStoryEntity() {
    return items?.map(
          (e) {
            final fullThumbUrl =
                '${appDomainCdnImage ?? ''}/uploads/comics/${e.thumbUrl}';

            return StoryEntity(
              id: e.fullId,
              name: e.name ?? '',
              thumb: fullThumbUrl,
              process:
                  'Chương ${e.chaptersLatest?.firstOrNull?.chapterName ?? 0}',
            );
          },
        ).toList() ??
        [];
  }
}
