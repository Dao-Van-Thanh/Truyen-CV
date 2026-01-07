import 'package:flutter_template/dependency/api/api_service.dart';
import 'package:flutter_template/dependency/api/extension/response_extension.dart';
import 'package:flutter_template/dependency/api/model/api_result.dart';
import 'package:flutter_template/dependency/network_api/base/base_data_response_model.dart';
import 'package:flutter_template/dependency/network_api/story/category/category_model.dart';
import 'package:flutter_template/dependency/network_api/story/chapter/chapter_response.dart';
import 'package:flutter_template/dependency/network_api/story/detail/story_detail_response.dart';
import 'package:flutter_template/dependency/network_api/story/filter/story_filter_request.dart';
import 'package:flutter_template/dependency/network_api/story/filter/story_filter_response.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';

class StoryRepository {
  final ApiService apiService;

  StoryRepository(this.apiService);

  Future<ApiResult<BaseDataResponseModel<List<CategoryModel>>>>
      getListCategory() async {
    final response = await apiService.get(
      '/getListCategory',
      shouldCache: true,
    );

    return response.parseData(
      (json) => BaseDataResponseModel<List<CategoryModel>>.fromJson(
        json,
        (data) => (data as List<dynamic>)
            .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
  }

  Future<ApiResult<StoryFilterResponse>> getStoryFilter({
    required StoryFilterRequest req,
  }) async {
    final res = await apiService.post(
      '/filter',
      queryParameters: req.toJson(),
    );

    return res.parseData(
      (json) => StoryFilterResponse.fromJson(json),
    );
  }

  Future<ApiResult<BaseDataResponseModel<StoryDetailResponse>>> storyDetail(
    String storyId,
  ) async {
    final res = await apiService.get(
      '/story',
      queryParameters: {
        'story_id': storyId,
      },
    );

    return res.parseData(
      (json) => BaseDataResponseModel<StoryDetailResponse>.fromJson(
        json,
        (data) => StoryDetailResponse.fromJson(data as Map<String, dynamic>),
      ),
    );
  }

  Future<ApiResult<BaseDataResponseModel<List<ListChapterRes>>>> getListChapter(
    String storyId,
  ) async {
    final response = await apiService.get(
      '/listchap',
      queryParameters: {
        'story_id': storyId,
      },
    );

    return response.parseData(
      (json) => BaseDataResponseModel<List<ListChapterRes>>.fromJson(
        json,
        (data) => (data as List<dynamic>)
            .map((e) => ListChapterRes.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
  }

  Future<ApiResult<BaseDataResponseModel<ChapterResponse>>> getChapter(
    String chapterId,
  ) async {
    final res = await apiService.get(
      '/chapter',
      queryParameters: {
        'chapter_id': chapterId,
      },
    );

    // ChapterResponse
    return res.parseData(
      (json) => BaseDataResponseModel<ChapterResponse>.fromJson(
        json,
        (data) => ChapterResponse.fromJson(data as Map<String, dynamic>),
      ),
    );
  }

  Future<ApiResult<StoryFilterResponse>> searchStory({
    required int page,
    required String keyword,
  }) async {
    final res = await apiService.get(
      '/tim-kiem',
      queryParameters: {
        'page_number': page,
        'k': keyword,
      },
    );

    return res.parseData(
      (json) => StoryFilterResponse.fromJson(json),
    );
  }
}
