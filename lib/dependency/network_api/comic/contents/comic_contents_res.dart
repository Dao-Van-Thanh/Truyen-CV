import 'package:truyen_cv/features/story/read_comic/entities/comic_chapter_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';

part 'comic_contents_res.freezed.dart';
part 'comic_contents_res.g.dart';

@freezed
abstract class ComicContentsRes with _$ComicContentsRes {
  const factory ComicContentsRes({
    @JsonKey(name: 'domain_cdn') String? domainCdn,
    @JsonKey(name: 'item') ComicChapterItemModel? item,
  }) = _ComicContentsRes;

  factory ComicContentsRes.fromJson(Map<String, dynamic> json) =>
      _$ComicContentsResFromJson(json);
}

@freezed
abstract class ComicChapterItemModel with _$ComicChapterItemModel {
  const factory ComicChapterItemModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'comic_name') String? comicName,
    @JsonKey(name: 'chapter_name') String? chapterName,
    @JsonKey(name: 'chapter_title') String? chapterTitle,
    @JsonKey(name: 'chapter_path') String? chapterPath,
    @JsonKey(name: 'chapter_image') List<ComicImagePageModel>? chapterImage,
  }) = _ComicChapterItemModel;

  factory ComicChapterItemModel.fromJson(Map<String, dynamic> json) =>
      _$ComicChapterItemModelFromJson(json);
}

@freezed
abstract class ComicImagePageModel with _$ComicImagePageModel {
  const factory ComicImagePageModel({
    @JsonKey(name: 'image_page') int? imagePage,
    @JsonKey(name: 'image_file') String? imageFile,
  }) = _ComicImagePageModel;

  factory ComicImagePageModel.fromJson(Map<String, dynamic> json) =>
      _$ComicImagePageModelFromJson(json);
}

extension ComicContentsResExtension on ComicContentsRes {
  ComicChapterEntity toEntity() {
    final pages = item?.chapterImage?.map(
          (e) {
            final domain = domainCdn ?? '';
            final path = item?.chapterPath ?? '';
            final file = e.imageFile ?? '';

            final url = join(domain, path, file);
            return ComicPageEntity(
              index: e.imagePage ?? -1,
              url: url,
            );
          },
        ).toList() ??
        [];

    return ComicChapterEntity(
      id: item?.id ?? '',
      name: item?.chapterName ?? '',
      pages: pages,
    );
  }
}
