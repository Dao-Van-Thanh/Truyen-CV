import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/features/story/read_story/extension/read_story_tts_extension.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/widgets/gesture_detector/app_gesture_detector.dart';

class ReadStoryController extends ConsumerWidget {
  const ReadStoryController({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.readStory);
    final t = context.t;

    return ObsBuilder(
      streams: [
        bloc.isMenuVisibleSubject,
        bloc.configStorySubject,
        bloc.currentListChapterItemSubject,
      ],
      builder: (context) {
        final isVisible = bloc.isMenuVisibleSubject.value;
        final currentListChapterItem = bloc.currentListChapterItemSubject.value;
        const duration = Duration(milliseconds: 300);
        const curve = Curves.easeInOut;
        final config = bloc.configStorySubject.value;
        final backgroundColor = config.themeMode.backgroundControllerColor;
        final listChapters = bloc.args.listChapter;

        final textColor = config.themeMode.textColor;

        return IgnorePointer(
          ignoring: !isVisible,
          child: Column(
            children: [
              AnimatedSlide(
                duration: duration,
                curve: curve,
                offset: isVisible ? Offset.zero : const Offset(0, -1),
                child: Container(
                  height: kToolbarHeight + MediaQuery.of(context).padding.top,
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                  ),
                  child: Row(
                    children: [
                      BackButton(color: textColor),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.bookmark_border, color: textColor),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert, color: textColor),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => bloc.toggleMenuVisibility(),
                  behavior: HitTestBehavior.translucent,
                  child: Container(color: Colors.transparent),
                ),
              ),
              AnimatedSlide(
                duration: duration,
                curve: curve,
                offset: isVisible ? Offset.zero : const Offset(0, 1),
                child: Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                  ),
                  padding: const EdgeInsets.all(16).copyWith(
                    bottom: 16 + MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentListChapterItem?.name ?? '',
                        style: TextStyle(
                          color: textColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: AppGestureDetector(
                              onTap: bloc.onTapPreviousPage,
                              child: Text(
                                t.readStory.prev,
                                style: TextStyle(
                                  color: textColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Slider(
                              value: (bloc.pageController.page ?? 0),
                              min: 0,
                              max: (listChapters.isEmpty
                                      ? 1
                                      : listChapters.length) -
                                  1,
                              onChanged: bloc.onChangeReadProgress,
                              activeColor: textColor,
                              inactiveColor: textColor.withValues(alpha: 0.5),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AppGestureDetector(
                              onTap: bloc.onTapNextPage,
                              child: Text(
                                t.readStory.next,
                                style: TextStyle(
                                  color: textColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.menu, color: textColor),
                            onPressed: () {},
                          ),
                          IconButton(
                            onPressed: bloc.onTapStartTts,
                            icon: Icon(Icons.headphones, color: textColor),
                          ),
                          IconButton(
                            icon: Icon(Icons.settings, color: textColor),
                            onPressed: bloc.onTapSettings,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
