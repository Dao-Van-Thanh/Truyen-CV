// domain/repository/read_story_source.dart

import 'package:truyen_cv/dependency/network_api/novel/chapter/chapter_response.dart';
import 'package:truyen_cv/dependency/network_api/novel/detail/story_detail_response.dart';
import 'package:truyen_cv/dependency/network_api/novel/list_chapter/list_chapter_res.dart';

abstract class IReadStorySource {
  Future<ChapterResponse?> getChapter(String chapterId);

  Future<List<ListChapterRes>?> getListChapter(String storyId);

  Future<StoryDetailResponse?> getStoryDetail(String storyId);
}
