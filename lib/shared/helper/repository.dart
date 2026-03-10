import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/dependency/api/model/api_result.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/story_entity.dart';
import 'package:flutter_template/dependency/network_api/base/base_data_response_model.dart';
import 'package:flutter_template/dependency/network_api/comic/detail/comic_detail_res.dart';
import 'package:flutter_template/dependency/network_api/comic/list_comic/list_comic_res.dart';
import 'package:flutter_template/dependency/network_api/novel/detail/story_detail_response.dart';
import 'package:flutter_template/dependency/network_api/novel/filter/story_filter_response.dart';
import 'package:flutter_template/dependency/network_api/novel/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/features/story/detail/entities/story_detail_entity.dart';
import 'package:flutter_template/shared/utilities/logger.dart';

class RepositoryHelper {
  static Future<StoryDetailEntity?> fetchStoryNovelDetail(
    Ref ref, {
    required String storyId,
  }) async {
    final networkApiService = ref.read(AppService.networkApi);
    final res = await Future.wait([
      networkApiService.novelRepository.storyDetail(storyId),
      networkApiService.novelRepository.getListChapter(storyId),
    ]);
    final storyDetailRes =
        res[0] as ApiResult<BaseDataResponseModel<StoryDetailResponse>>;
    final listChapterRes =
        res[1] as ApiResult<BaseDataResponseModel<List<ListChapterRes>>>;

    if (storyDetailRes.hasError || listChapterRes.hasError) {
      logger.e(
        'Failed to fetch story detail: ${storyDetailRes.error ?? listChapterRes.error}',
      );
      return null;
    }

    if (storyDetailRes.isHandled || listChapterRes.isHandled) {
      return null;
    }

    StoryDetailEntity? storyDetail = storyDetailRes.data?.data?.toEntity();

    final listChapter = listChapterRes.data?.data ?? [];

    storyDetail = storyDetail?.copyWith(
      listChapter: listChapter.map((e) => e.toEntity()).toList(),
    );

    return storyDetail;
  }

  static Future<StoryDetailEntity?> fetchStoryComicDetail(
    Ref ref, {
    required String storyId,
  }) async {
    final networkApiService = ref.read(AppService.networkApi);

    final storySlug = storyId.split('||').lastOrNull ?? '';
    final res =
        await networkApiService.comicRepository.getComicDetail(storySlug);

    return res.whenOrNull<StoryDetailEntity?>(
      success: (data) => data.data?.toEntity(),
      error: (e) {
        logger.e('Failed to fetch comic detail ${e}');
        return null;
      },
    );
  }

  static Future<List<StoryEntity>> fetchStoryNovelSearch(
    Ref ref, {
    required String keyword,
    required int page,
  }) async {
    final networkApiService = ref.read(AppService.networkApi);
    final res = await networkApiService.novelRepository.searchStory(
      keyword: keyword,
      page: page,
    );

    return res.whenOrNull<List<StoryEntity>>(
          success: (data) => data.data?.map((e) => e.toEntity()).toList() ?? [],
          error: (e) {
            logger.e('Failed to search story ${e}');
            return [];
          },
        ) ??
        [];
  }

  static Future<List<StoryEntity>> fetchStoryComicSearch(
    Ref ref, {
    required String keyword,
    required int page,
  }) async {
    final networkApiService = ref.read(AppService.networkApi);
    final res = await networkApiService.comicRepository.searchComic(
      keyword,
      page: page,
    );

    return res.whenOrNull<List<StoryEntity>>(
          success: (data) => data.data?.toStoryEntity() ?? [],
          error: (e) {
            logger.e('Failed to search comic ${e}');
            return [];
          },
        ) ??
        [];
  }

  RepositoryHelper._();
}
