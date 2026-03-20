// data/source/online_read_story_source.dart

import 'package:truyen_cv/dependency/network_api/network_api_service.dart';
import 'package:truyen_cv/dependency/network_api/novel/chapter/chapter_response.dart';
import 'package:truyen_cv/dependency/network_api/novel/detail/story_detail_response.dart';
import 'package:truyen_cv/dependency/network_api/novel/list_chapter/list_chapter_res.dart';
import 'package:truyen_cv/features/story/read_story/data/source/read_story_source.dart';
import 'package:truyen_cv/shared/utilities/logger.dart';

class OnlineReadStorySource implements IReadStorySource {
  final NetworkApiService _networkApi;

  OnlineReadStorySource(this._networkApi);

  @override
  Future<ChapterResponse?> getChapter(String chapterId) async {
    final res = await _networkApi.novelRepository.getChapter(chapterId);
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
    final res = await _networkApi.novelRepository.getListChapter(storyId);
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
    final res = await _networkApi.novelRepository.storyDetail(storyId);
    return res.whenOrNull<StoryDetailResponse?>(
      success: (data) => data.data,
      error: (error) {
        logger.e('Error fetching story detail: ${error.errorMessage}');
        return null;
      },
    );
  }
}
