import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/dependency/api/model/api_result.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/network_api/base/base_data_response_model.dart';
import 'package:flutter_template/dependency/network_api/novel/detail/story_detail_response.dart';
import 'package:flutter_template/dependency/network_api/novel/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/features/story/detail/entities/story_detail_entity.dart';

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

  RepositoryHelper._();
}
