import 'package:flutter_template/dependency/local_api/local_api_service.dart';
import 'package:flutter_template/dependency/network_api/story/chapter/chapter_response.dart';
import 'package:flutter_template/dependency/network_api/story/detail/story_detail_response.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/features/story/read_story/data/source/read_story_source.dart';
import 'package:flutter_template/shared/utilities/logger.dart';

class LocalReadStorySource implements IReadStorySource {
  final LocalApiService _localApi;

  LocalReadStorySource(this._localApi);

  @override
  Future<ChapterResponse?> getChapter(String chapterId) async {
    try {
      final chapterContent =
          await _localApi.chapterRepository.getChapterContent(chapterId);

      if (chapterContent == null || chapterContent.content.isEmpty) {
        return null;
      }

      return ChapterResponse(
        id: chapterId,
        content: chapterContent.content,
      );
    } catch (e) {
      logger.e('LocalSource: Lỗi lấy chapter $chapterId: $e');
      return null;
    }
  }

  @override
  Future<List<ListChapterRes>?> getListChapter(String storyId) async {
    try {
      final chapters =
          await _localApi.chapterRepository.getChaptersByBookId(storyId);

      if (chapters.isEmpty) return null;

      return chapters;
    } catch (e) {
      logger.e('LocalSource: Lỗi lấy list chapter: $e');
      return null;
    }
  }

  @override
  Future<StoryDetailResponse?> getStoryDetail(String storyId) async {
    try {
      final bookEntity = await _localApi.bookRepository.getBookById(storyId);

      if (bookEntity == null) return null;

      final storyModel = bookEntity.storyModel;

      return StoryDetailResponse(
        id: storyModel.id,
        name: storyModel.name,
        author: storyModel.author,
        thumb: storyModel.thumb,
        totalChapter: bookEntity.listChapters.length.toString(),
      );
    } catch (e) {
      logger.e('LocalSource: Lỗi lấy story detail: $e');
      return null;
    }
  }
}
