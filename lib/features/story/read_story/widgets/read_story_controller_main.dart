import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/constants/constants.dart';
import 'package:flutter_template/features/story/read_story/extension/read_story_tts_extension.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/widgets/gesture_detector/app_gesture_detector.dart';

const _curve = Curves.easeInOut;
const _duration = Duration(milliseconds: 300);

class MainController extends ConsumerWidget {
  final bool isVisible;
  final Color backgroundColor;
  final Color textColor;

  const MainController({
    super.key,
    required this.isVisible,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.readStory);
    final t = context.t;
    return ObsBuilder(
      streams: [
        bloc.currentListChapterItemSubject,
      ],
      builder: (context) {
        final currentListChapterItem = bloc.currentListChapterItemSubject.value;
        final listChapters = bloc.args.listChapter;
        return Column(
          children: [
            AnimatedSlide(
              duration: _duration,
              curve: _curve,
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
                            child: Padding(
                              padding: EdgeInsetsConstants.vertical16,
                              child: Text(
                                t.readStory.prev,
                                style: TextStyle(
                                  color: textColor,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
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
                            child: Padding(
                              padding: EdgeInsetsConstants.vertical16,
                              child: Text(
                                t.readStory.next,
                                style: TextStyle(
                                  color: textColor,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(Icons.menu, color: textColor),
                        ),
                        InkWell(
                          onTap: bloc.onTapStartTts,
                          child: Icon(Icons.headphones, color: textColor),
                        ),
                        InkWell(
                          onTap: bloc.onTapSettings,
                          child: Icon(Icons.settings, color: textColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
