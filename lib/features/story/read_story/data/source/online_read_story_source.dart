// data/source/online_read_story_source.dart

import 'package:flutter_template/dependency/network_api/network_api_service.dart';
import 'package:flutter_template/dependency/network_api/story/chapter/chapter_response.dart';
import 'package:flutter_template/dependency/network_api/story/detail/story_detail_response.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/features/story/read_story/data/source/read_story_source.dart';
import 'package:flutter_template/shared/utilities/logger.dart';

class OnlineReadStorySource implements IReadStorySource {
  final NetworkApiService _networkApi;

  OnlineReadStorySource(this._networkApi);

  @override
  Future<ChapterResponse?> getChapter(String chapterId) async {
    final res = await _networkApi.storyRepository.getChapter(chapterId);
    return res.whenOrNull<ChapterResponse?>(
      success: (data) => data.data,
      error: (error) {
        logger.e('Error fetching chapter: ${error.errorMessage}');
        return null;
      },
    );
  }

  @override
  Future<List<ListChapterRes>?> getListChapter(String storyId) async {
    final res = await _networkApi.storyRepository.getListChapter(storyId);
    return res.whenOrNull<List<ListChapterRes>?>(
      success: (data) => data.data,
      error: (error) {
        logger.e('Error fetching list chapter: ${error.errorMessage}');
        return null;
      },
    );
  }

  @override
  Future<StoryDetailResponse?> getStoryDetail(String storyId) async {
    final res = await _networkApi.storyRepository.storyDetail(storyId);
    return res.whenOrNull<StoryDetailResponse?>(
      success: (data) => data.data,
      error: (error) {
        logger.e('Error fetching story detail: ${error.errorMessage}');
        return null;
      },
    );
  }
}
