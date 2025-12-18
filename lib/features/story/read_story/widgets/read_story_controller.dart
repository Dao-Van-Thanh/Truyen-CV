import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/features/story/read_story/widgets/read_story_controller_main.dart';
import 'package:flutter_template/features/story/read_story/widgets/read_story_controller_tts.dart';

const _curve = Curves.easeInOut;
const _duration = Duration(milliseconds: 300);

class ReadStoryController extends ConsumerWidget {
  const ReadStoryController({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.readStory);

    return ObsBuilder(
      streams: [
        bloc.isMenuVisibleSubject,
        bloc.ttsControllerStatusSubject,
        bloc.configStorySubject,
      ],
      builder: (context) {
        final isVisible = bloc.isMenuVisibleSubject.value;
        final ttsStatus = bloc.ttsControllerStatusSubject.value;
        final config = bloc.configStorySubject.value;
        final backgroundColor = config.themeMode.backgroundControllerColor;
        final textColor = config.themeMode.textColor;

        Widget child = MainController(
          isVisible: isVisible,
          backgroundColor: backgroundColor,
          textColor: textColor,
        );

        if (!ttsStatus.isStopped) {
          child = TtsController(
            isVisible: isVisible,
            backgroundColor: backgroundColor,
            textColor: textColor,
          );
        }

        return IgnorePointer(
          ignoring: !isVisible,
          child: child,
        );
      },
    );
  }
}
