import 'package:flutter_template/dependency/network_api/story/chapter/chapter_response.dart';
import 'package:flutter_template/features/story/read_story/enum/read_tts_status.dart';
import 'package:flutter_template/features/story/read_story/read_story_bloc.dart';
import 'package:flutter_template/shared/utilities/logger.dart';

extension ReadStoryTtsExtension on ReadStoryBloc {
  void initTts() {
    tts.initTts();
    tts.onChapterFinished = () {
      onTapNextPageTtsChapter();
    };
  }

  void onTapPlayToIndex(int index, String chapterId) {
    final currentChapterId = tts.currentChapterId;
    if (chaptersMapSubject.value.isEmpty) {
      logger.e('No chapter to read');
      return;
    }
    if (currentChapterId != chapterId) {
      final chapterContent = chaptersMapSubject.value[chapterId];
      final paragraphs = chapterContent?.paragraphs ?? [];
      tts.setData(paragraphs, startIndex: index);
      tts.playToIndex(index, chapterId);
      ttsControllerStatusSubject.add(ReadTtsStatus.playing);
      return;
    }
    tts.playToIndex(index, chapterId);
    ttsControllerStatusSubject.add(ReadTtsStatus.playing);
  }

  void onTapStartTts({int countReload = 0}) {
    final currentChapter = currentListChapterItemSubject.value;
    if (currentChapter == null || chaptersMapSubject.value.isEmpty) {
      logger.e('No chapter to read');
      return;
    }

    if (currentChapter.id == null) {
      logger.e('Current chapter id is null');
      return;
    }

    final chapterContent = chaptersMapSubject.value[currentChapter.id];

    final paragraphs = chapterContent?.paragraphs ?? [];
    if (paragraphs.isEmpty) {
      // có thể chapter đang load nên cần check lại 1 lần sau mỗi 500 milliseconds, nếu check >= 3 lần thì chaoter có thể lỗi -> cancel
      if (countReload >= 3) {
        logger.e(
          'Chapter content is empty for chapterId: ${currentChapter.id}',
        );
        return;
      }
      reloadTtsStartDebounce.run(() {
        onTapStartTts(countReload: countReload + 1);
      });
      return;
    }
    tts.setData(paragraphs);
    tts.playToIndex(0, currentChapter.id ?? '');
    ttsControllerStatusSubject.add(ReadTtsStatus.playing);
  }

  void onTapResumeOrPauseTts() {
    if (ttsControllerStatusSubject.value == ReadTtsStatus.playing) {
      tts.pause();
      ttsControllerStatusSubject.add(ReadTtsStatus.paused);
      return;
    }
    tts.play(tts.currentChapterId);
    ttsControllerStatusSubject.add(ReadTtsStatus.playing);
  }

  void onTapStopTts() {
    ttsControllerStatusSubject.add(ReadTtsStatus.stopped);
    tts.stop();
  }

  void onTapNextParagraph() {
    tts.nextParagraph();
    ttsControllerStatusSubject.add(ReadTtsStatus.playing);
  }

  void onTapPreviousParagraph() {
    tts.previousParagraph();
    ttsControllerStatusSubject.add(ReadTtsStatus.playing);
  }

  void onTapNextPageTtsChapter() {
    onTapNextPage();
    Future.delayed(const Duration(milliseconds: 500), () {
      onTapStartTts();
    });
  }

  void onTapPreviousPageTtsChapter() {
    onTapPreviousPage();
    Future.delayed(const Duration(milliseconds: 500), () {
      onTapStartTts();
    });
  }
}
