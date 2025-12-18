import 'package:flutter/material.dart';
import 'package:flutter_template/dependency/network_api/story/chapter/chapter_response.dart';
import 'package:flutter_template/features/story/read_story/enum/read_tts_status.dart';
import 'package:flutter_template/features/story/read_story/read_story_bloc.dart';
import 'package:flutter_template/features/story/read_story/widgets/read_story_timer_settings.dart';
import 'package:flutter_template/features/story/read_story/widgets/read_story_tts_settings.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/utilities/logger.dart';

extension ReadStoryTtsExtension on ReadStoryBloc {
  void initTts() {
    tts.initTts();
    _initTimer();
    tts.onChapterFinished = () {
      onTapNextPageTtsChapter();
    };
    _loadVoices();
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

  void onTapResumeOrPauseTts({bool? isPause}) {
    if (ttsControllerStatusSubject.value == ReadTtsStatus.playing) {
      _onPause();
      return;
    }
    _onResume();
  }

  void _onPause() {
    if (ttsControllerStatusSubject.value != ReadTtsStatus.playing) {
      return;
    }
    tts.pause();
    ttsControllerStatusSubject.add(ReadTtsStatus.paused);
  }

  void _onResume() {
    if (ttsControllerStatusSubject.value != ReadTtsStatus.paused) {
      return;
    }
    tts.play(tts.currentChapterId);
    ttsControllerStatusSubject.add(ReadTtsStatus.playing);
  }

  void onTapStopTts() {
    ttsControllerStatusSubject.add(ReadTtsStatus.stopped);
    tts.stop();
    cancelSleepTimer();
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

  void onTapSettingsTts() {
    _onPause();
    toggleMenuVisibility();
    showModalBottomSheet(
      context: routerService.rootContext,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return ReadStoryTtsSettings();
      },
    ).then((_) {
      tts.setConfig(ttsConfigSubject.value).then((_) {
        _onResume();
      });
    });
  }

  void onChangeTtsRate(double rate) {
    final current = ttsConfigSubject.value;
    ttsConfigSubject.add(current.copyWith(rate: rate));
  }

  void onChangeTtsPitch(double pitch) {
    final current = ttsConfigSubject.value;
    ttsConfigSubject.add(current.copyWith(pitch: pitch));
  }

  void onChangeTtsVoice(Map<String, String> voice) {
    final current = ttsConfigSubject.value;
    ttsConfigSubject.add(current.copyWith(selectedVoice: voice));
  }

  void onTapResetTtsSettings() {
    ttsResetSettingsHelper.execute(
      onFirstTap: () {
        toastService.showText(
          message: t.readStory.resetSettingsToDefaultConfirm,
        );
      },
      onConfirmed: () {
        toastService.showText(
          message: t.readStory.resetSettingsToDefaultSuccess,
        );
        final currentConfig = ttsConfigSubject.value;
        final newConfig = currentConfig.resetAudioSettings();
        ttsConfigSubject.add(newConfig);
      },
    );
  }

  void _loadVoices() async {
    final voices = await tts.getVoices();
    final currentConfig = ttsConfigSubject.value;

    Map<String, String>? defaultVoice;

    final defaultLang = 'vi-VN';
    final voicesInLang =
        voices.where((e) => e['locale'] == defaultLang).toList();

    if (voicesInLang.isNotEmpty) {
      defaultVoice = voicesInLang.first;
    } else if (voices.isNotEmpty) {
      defaultVoice = voices.first; // Lấy cái đầu tiên bất kỳ
    }

    ttsConfigSubject.add(
      currentConfig.copyWith(
        availableVoices: voices,
        selectedLanguage: defaultVoice?['locale'] ?? defaultLang,
        selectedVoice: defaultVoice,
      ),
    );
  }

  void onChangeLanguage(String? language) {
    if (language == null) return;

    final currentConfig = ttsConfigSubject.value;

    final voicesInNewLang = currentConfig.availableVoices
        .where((e) => e['locale'] == language)
        .toList();

    final newVoice = voicesInNewLang.isNotEmpty ? voicesInNewLang.first : null;

    ttsConfigSubject.add(
      currentConfig.copyWith(
        selectedLanguage: language,
        selectedVoice: newVoice,
      ),
    );
  }

  void onTapTryTtsVoice() {
    tts.previewVoice(ttsConfigSubject.value);
  }

  void _initTimer() {
    ttsTimerHelper.remainingTimeStream.listen((seconds) {
      if (isDispose) return;
      if (seconds < 0) {
        isTimerRunningSubject.add(false);
        timerStringSubject.add('');
      } else {
        isTimerRunningSubject.add(true);
        timerStringSubject.add(ttsTimerHelper.formatTime(seconds));
      }
    });

    ttsTimerHelper.onTimerFinished = () {
      _onPause();
      toastService.showText(message: 'Đã dừng đọc do hẹn giờ kết thúc');
    };
  }

  void onTapScheduleTts() {
    toggleMenuVisibility();
    showModalBottomSheet(
      context: routerService.rootContext,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return ReadStoryTimerSettings();
      },
    );
  }

  void setSleepTimer(int minutes) {
    ttsTimerHelper.startTimer(minutes);
  }

  void cancelSleepTimer() {
    ttsTimerHelper.stopTimer();
  }
}
