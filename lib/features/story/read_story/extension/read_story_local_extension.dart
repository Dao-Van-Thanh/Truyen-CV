import 'package:flutter/foundation.dart';
import 'package:flutter_template/constants/config.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:flutter_template/dependency/local_api/repository/config/entities/config_entity.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/dependency/router/utils/route_name.dart';
import 'package:flutter_template/features/story/read_story/model/config_story_model.dart';
import 'package:flutter_template/features/story/read_story/read_story_bloc.dart';
import 'package:flutter_template/shared/utilities/logger.dart';

extension ReadStoryLocalExtension on ReadStoryBloc {
  Future<void> getConfigLocal() async {
    try {
      final configLocal = await localApiService.configRepository.getConfig();
      if (isDispose) return;
      final config = configLocal?.toConfigModel();
      configStorySubject.value = config ?? defaultConfigStory;
    } catch (e) {
      logger.e('Error loading config from local: $e');
    }
  }

  Future<void> saveConfigLocal(ConfigStoryModel config) async {
    try {
      final configEntity = ConfigEntity(
        fontFamily: config.fontFamily,
        fontSize: config.fontSize,
        themeMode: config.themeMode.name,
        timeStamp: DateTime.now().toIso8601String(),
        lineHeight: config.lineHeight,
      );
      await localApiService.configRepository.saveConfig(configEntity);
    } catch (e) {
      logger.e('Error saving config to local: $e');
    }
  }

  Future<void> saveRouterLocal() async {
    try {
      await localApiService.routerRepository.saveCurrentRoute(
        RouteName.readStory,
        storyId,
      );
    } catch (e) {
      logger.e('Error saving router to local: $e');
    }
  }

  Future<void> clearRouterLocal() async {
    try {
      await localApiService.routerRepository.clearCurrentRoute();
    } catch (e) {
      logger.e('Error clearing router from local: $e');
    }
  }

  Future<void> upsertBookLocal({
    required String chapterId,
    required double scrollOffset,
    required String lastReadTime,
    required List<ListChapterRes> listChapters,
  }) async {
    final currentBook = await localApiService.bookRepository.getBookById(
      storyId,
    );
    if (currentBook == null) {
      logger.e(
        'Failed to upsert book to local, book not found for storyId: ${storyId}',
      );
      return;
    }
    BookEntity newBook = currentBook.copyWith(
      currentChapterId: chapterId,
      scrollOffset: scrollOffset,
      lastReadTime: lastReadTime,
      timeStamp: DateTime.now().toIso8601String(),
    );

    final isSameListChapters = listEquals(
      listChapters,
      currentBook.listChapters,
    );

    if (!isSameListChapters) {
      newBook = newBook.copyWith(
        listChapters: listChapters,
      );
    }

    await localApiService.bookRepository.upsertBook(
      newBook,
      isHasUpdateListChapter: !isSameListChapters,
    );
  }
}
