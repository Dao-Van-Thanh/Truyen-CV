import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/extensions/color.dart';
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
        bloc.themeModeSubject,
        bloc.currentListChapterItemSubject,
      ],
      builder: (context) {
        final isVisible = bloc.isMenuVisibleSubject.value;
        final chapter = bloc.currentListChapterItemSubject.value;
        const duration = Duration(milliseconds: 300);
        const curve = Curves.easeInOut;
        final themeMode = bloc.themeModeSubject.value;
        const double alpha = 0.95;
        final backgroundColor =
            themeMode.backgroundColor.withValues(alpha: alpha).darkenColor();

        final textColor = themeMode.textColor;

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
                        chapter?.name ?? '',
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
                              value: 0.0,
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
                            onPressed: () {},
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
