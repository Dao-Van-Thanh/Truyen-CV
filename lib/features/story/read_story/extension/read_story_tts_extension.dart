import 'package:flutter_template/features/story/read_story/enum/read_tts_status.dart';
import 'package:flutter_template/features/story/read_story/read_story_bloc.dart';

extension ReadStoryTtsExtension on ReadStoryBloc {
  void onTapStartTts() {
    ttsControllerStatusSubject.add(ReadTtsStatus.playing);
  }

  void onChapterTtsFinished(int index) {
    onTapNextPage();
  }
}
