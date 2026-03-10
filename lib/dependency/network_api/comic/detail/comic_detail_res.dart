import 'package:flutter_template/dependency/local_api/repository/book/entities/list_chapter_entity.dart';
import 'package:flutter_template/dependency/local_api/repository/book/enum/story_type.dart';
import 'package:flutter_template/features/story/detail/entities/story_detail_entity.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/utilities/string.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comic_detail_res.freezed.dart';
part 'comic_detail_res.g.dart';

@freezed
abstract class ComicDetailRes with _$ComicDetailRes {
  @JsonSerializable(explicitToJson: true)
  const factory ComicDetailRes({
    @JsonKey(name: 'seoOnPage') ComicSeoOnPage? seoOnPage,
    @JsonKey(name: 'breadCrumb') List<ComicBreadCrumb>? breadCrumb,
    @JsonKey(name: 'params') ComicParams? params,
    @JsonKey(name: 'item') ComicItem? item,
    @JsonKey(name: 'APP_DOMAIN_CDN_IMAGE') String? appDomainCdnImage,
  }) = _ComicDetailRes;

  factory ComicDetailRes.fromJson(Map<String, dynamic> json) =>
      _$ComicDetailResFromJson(json);
}

@freezed
abstract class ComicSeoOnPage with _$ComicSeoOnPage {
  @JsonSerializable(explicitToJson: true)
  const factory ComicSeoOnPage({
    @JsonKey(name: 'og_type') String? ogType,
    @JsonKey(name: 'titleHead') String? titleHead,
    @JsonKey(name: 'seoSchema') ComicSeoSchema? seoSchema,
    @JsonKey(name: 'descriptionHead') String? descriptionHead,
    @JsonKey(name: 'og_image') List<String>? ogImage,
    @JsonKey(name: 'updated_time') int? updatedTime,
    @JsonKey(name: 'og_url') String? ogUrl,
  }) = _ComicSeoOnPage;

  factory ComicSeoOnPage.fromJson(Map<String, dynamic> json) =>
      _$ComicSeoOnPageFromJson(json);
}

@freezed
abstract class ComicSeoSchema with _$ComicSeoSchema {
  @JsonSerializable()
  const factory ComicSeoSchema({
    @JsonKey(name: '@context') String? context,
    @JsonKey(name: '@type') String? type,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'director') String? director,
  }) = _ComicSeoSchema;

  factory ComicSeoSchema.fromJson(Map<String, dynamic> json) =>
      _$ComicSeoSchemaFromJson(json);
}

@freezed
abstract class ComicBreadCrumb with _$ComicBreadCrumb {
  @JsonSerializable()
  const factory ComicBreadCrumb({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'position') int? position,
    @JsonKey(name: 'isCurrent') bool? isCurrent,
  }) = _ComicBreadCrumb;

  factory ComicBreadCrumb.fromJson(Map<String, dynamic> json) =>
      _$ComicBreadCrumbFromJson(json);
}

@freezed
abstract class ComicParams with _$ComicParams {
  @JsonSerializable()
  const factory ComicParams({
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'crawl_check_url') String? crawlCheckUrl,
  }) = _ComicParams;

  factory ComicParams.fromJson(Map<String, dynamic> json) =>
      _$ComicParamsFromJson(json);
}

@freezed
abstract class ComicItem with _$ComicItem {
  @JsonSerializable(explicitToJson: true)
  const factory ComicItem({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'origin_name') List<String>? originName,
    @JsonKey(name: 'content') String? content,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'thumb_url') String? thumbUrl,
    @JsonKey(name: 'sub_docquyen') bool? subDocquyen,
    @JsonKey(name: 'author') List<String>? author,
    @JsonKey(name: 'category') List<ComicCategory>? category,
    @JsonKey(name: 'chapters') List<ComicChapterServer>? chapters,
    @JsonKey(name: 'updatedAt') String? updatedAt,
  }) = _ComicItem;

  factory ComicItem.fromJson(Map<String, dynamic> json) =>
      _$ComicItemFromJson(json);
}

@freezed
abstract class ComicCategory with _$ComicCategory {
  @JsonSerializable()
  const factory ComicCategory({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'slug') String? slug,
  }) = _ComicCategory;

  factory ComicCategory.fromJson(Map<String, dynamic> json) =>
      _$ComicCategoryFromJson(json);
}

@freezed
abstract class ComicChapterServer with _$ComicChapterServer {
  @JsonSerializable(explicitToJson: true)
  const factory ComicChapterServer({
    @JsonKey(name: 'server_name') String? serverName,
    @JsonKey(name: 'server_data') List<ComicChapter>? serverData,
  }) = _ComicChapterServer;

  factory ComicChapterServer.fromJson(Map<String, dynamic> json) =>
      _$ComicChapterServerFromJson(json);
}

@freezed
abstract class ComicChapter with _$ComicChapter {
  @JsonSerializable()
  const factory ComicChapter({
    @JsonKey(name: 'filename') String? filename,
    @JsonKey(name: 'chapter_name') String? chapterName,
    @JsonKey(name: 'chapter_title') String? chapterTitle,
    @JsonKey(name: 'chapter_api_data') String? chapterApiData,
  }) = _ComicChapter;

  factory ComicChapter.fromJson(Map<String, dynamic> json) =>
      _$ComicChapterFromJson(json);
}

extension ComicDetailResExtension on ComicDetailRes {
  StoryDetailEntity toEntity() {
    final firstServer = item?.chapters?.firstOrNull;
    final serverData = firstServer?.serverData ?? [];

    final id = '${item?.id ?? '-1'}||${item?.slug ?? '-1'}';
    final name = item?.name ?? '';
    final totalChapter = serverData.lastOrNull?.chapterName ?? '0';
    final desc = StringUtilities.removeHtmlTags(item?.content ?? '');
    final thumb = seoOnPage?.seoSchema?.image ?? '';

    final listChapter = serverData.map((chapter) {
      final idChapter =
          (chapter.chapterApiData ?? '-1').split('/').lastOrNull ?? '-1';

      return ListChapterEntity(
        id: idChapter,
        name: 'Chương ${chapter.chapterName ?? '---'}',
      );
    }).toList();

    final author = item?.author?.firstOrNull ?? '';

    final category = (breadCrumb ?? [])
        .where((element) => element.position == 2)
        .map((e) {
          return e.name;
        })
        .where((e) => e != null && e.trim().isNotEmpty)
        .join(', ');

    return StoryDetailEntity(
      id: id,
      name: name,
      totalChapter: totalChapter,
      desc: desc,
      thumb: thumb,
      listChapter: listChapter,
      author: author.isEmpty
          ? _formatStoryUpdatedTime(item?.updatedAt ?? '')
          : author,
      cat: '${t.comic.type.genres}: $category',
      trans: author.isEmpty
          ? null
          : _formatStoryUpdatedTime(item?.updatedAt ?? ''),
      type: StoryType.comic,
    );
  }

  String _formatStoryUpdatedTime(String? isoTime) {
    if (isoTime == null || isoTime.isEmpty) {
      return 'Chưa rõ thời gian cập nhật';
    }

    final dateTime = DateTime.tryParse(isoTime);
    if (dateTime == null) {
      return 'Chưa rõ thời gian cập nhật';
    }

    final now = DateTime.now().toUtc();
    final diff = now.difference(dateTime);

    String result;

    if (diff.inMinutes < 1) {
      result = 'Vừa cập nhật';
    } else if (diff.inHours < 1) {
      result = '${diff.inMinutes} phút trước';
    } else if (diff.inDays < 1) {
      result = '${diff.inHours} giờ trước';
    } else if (diff.inDays < 7) {
      result = '${diff.inDays} ngày trước';
    } else {
      result = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }

    return 'Cập nhật: $result';
  }
}
