import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/constants/constants.dart';
import 'package:flutter_template/features/story/read_story/extension/read_story_tts_extension.dart';
import 'package:flutter_template/features/story/read_story/widgets/blinking_red_dot.dart';

const _curve = Curves.easeInOut;
const _duration = Duration(milliseconds: 300);

class TtsController extends ConsumerWidget {
  final bool isVisible;
  final Color backgroundColor;
  final Color textColor;

  const TtsController({
    super.key,
    required this.isVisible,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.readStory);
    final ttsStatus = bloc.ttsControllerStatusSubject.value;
    final isPlaying = ttsStatus.isPlaying;

    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => bloc.toggleMenuVisibility(),
            behavior: HitTestBehavior.translucent,
            child: Container(color: Colors.transparent),
          ),
        ),
        AnimatedSlide(
          duration: _duration,
          curve: _curve,
          offset: isVisible ? Offset.zero : const Offset(0, 1),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            padding: const EdgeInsets.all(16).copyWith(
              bottom: 16 + MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButtonTtsIcon(
                      icon: Icons.skip_previous_outlined,
                      color: textColor,
                      onTap: bloc.onTapPreviousPageTtsChapter,
                    ),
                    SizedBoxConstants.s4,
                    _buildButtonTtsIcon(
                      icon: Icons.fast_rewind_outlined,
                      color: textColor,
                      onTap: bloc.onTapPreviousParagraph,
                    ),
                    SizedBoxConstants.s4,
                    _buildButtonTtsIcon(
                      icon: isPlaying ? Icons.pause : Icons.play_arrow,
                      padding: EdgeInsetsConstants.all14,
                      color: textColor,
                      onTap: bloc.onTapResumeOrPauseTts,
                    ),
                    SizedBoxConstants.s4,
                    _buildButtonTtsIcon(
                      icon: Icons.fast_forward_outlined,
                      color: textColor,
                      onTap: bloc.onTapNextParagraph,
                    ),
                    SizedBoxConstants.s4,
                    _buildButtonTtsIcon(
                      icon: Icons.skip_next_outlined,
                      color: textColor,
                      onTap: bloc.onTapNextPageTtsChapter,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ObsBuilder(
                      streams: [bloc.isTimerRunningSubject],
                      builder: (context) {
                        final isTimerRunning = bloc.isTimerRunningSubject.value;
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            IconButton(
                              onPressed: bloc.onTapScheduleTts,
                              icon: Icon(Icons.schedule, color: textColor),
                              iconSize: 28,
                            ),
                            if (isTimerRunning)
                              const Positioned(
                                top: 10,
                                right: 10,
                                child: BlinkingRedDot(),
                              ),
                          ],
                        );
                      },
                    ),
                    IconButton(
                      onPressed: bloc.onTapStopTts,
                      icon: Icon(Icons.power_settings_new, color: textColor),
                      iconSize: 28,
                    ),
                    IconButton(
                      onPressed: bloc.onTapSettingsTts,
                      icon: Icon(Icons.settings, color: textColor),
                      iconSize: 28,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonTtsIcon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    EdgeInsetsGeometry padding = const EdgeInsets.all(8),
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.2),
        ),
        child: Icon(icon, color: color),
      ),
    );
  }
}
