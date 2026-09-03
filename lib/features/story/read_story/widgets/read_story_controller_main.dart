import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truyen_cv/bloc/bloc_provider.dart';
import 'package:truyen_cv/bloc/rx/obs_builder.dart';
import 'package:truyen_cv/constants/constants.dart';
import 'package:truyen_cv/features/story/read_story/extension/read_story_tts_extension.dart';

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
    return Column(
      children: [
        AnimatedSlide(
          duration: _duration,
          curve: _curve,
          offset: isVisible ? Offset.zero : const Offset(0, -1),
          child: Container(
            height: kToolbarHeight + MediaQuery.of(context).padding.top,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            child: Row(
              children: [
                BackButton(
                  color: textColor,
                  onPressed: () {
                    Navigator.of(context).maybePop('FORCE_EXIT');
                  },
                ),
                Spacer(),
                ObsBuilder(
                  streams: [
                    bloc.isFavoriteSubject,
                  ],
                  builder: (context) {
                    final isFavorite = bloc.isFavoriteSubject.value;
                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.bookmark : Icons.bookmark_border,
                        color: textColor,
                      ),
                      onPressed: bloc.onTapFavoriteStory,
                    );
                  },
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
            child: Container(
              color: Colors.transparent,
              child: Align(
                alignment: Alignment.bottomRight,
                child: ObsBuilder(
                  streams: [bloc.backupIndexReadProcessSubject],
                  builder: (context) {
                    final isShow =
                        bloc.backupIndexReadProcessSubject.value != null;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedSlide(
                        duration: _duration,
                        curve: _curve,
                        offset: isShow && isVisible
                            ? Offset.zero
                            : const Offset(2, 0),
                        child: IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: backgroundColor,
                            shape: const CircleBorder(),
                          ),
                          onPressed: bloc.onBackupReadProgress,
                          icon: Icon(
                            Icons.lock_reset,
                            color: textColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
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
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ObsBuilder(
                  streams: [
                    bloc.currentListChapterItemSubject,
                  ],
                  builder: (context) {
                    final currentListChapterItem =
                        bloc.currentListChapterItemSubject.value;
                    return Text(
                      currentListChapterItem?.name ?? '',
                      style: TextStyle(
                        color: textColor,
                      ),
                      textAlign: TextAlign.left,
                    );
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: bloc.onTapPreviousPage,
                        icon: Padding(
                          padding: EdgeInsetsConstants.vertical16,
                          child: Icon(
                            Icons.chevron_left,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: ObsBuilder(
                        streams: [
                          bloc.listChapterSubject,
                        ],
                        builder: (context) {
                          final listChapters = bloc.listChapterSubject.value;
                          return ListenableBuilder(
                            listenable: bloc.pageController,
                            builder: (context, child) {
                              final value = bloc.pageController.page ?? 0;
                              return Slider(
                                value: value,
                                min: 0,
                                max: (listChapters.isEmpty
                                        ? 1
                                        : listChapters.length) -
                                    1,
                                onChanged: bloc.onChangeReadProgress,
                                activeColor: textColor,
                                inactiveColor: textColor.withAlpha(128),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: bloc.onTapNextPage,
                        icon: Padding(
                          padding: EdgeInsetsConstants.vertical16,
                          child: Icon(
                            Icons.chevron_right,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: bloc.onTapToggleDrawer,
                      icon: Icon(Icons.menu, color: textColor),
                    ),
                    IconButton(
                      onPressed: bloc.onTapStartTts,
                      icon: Icon(Icons.headphones, color: textColor),
                    ),
                    IconButton(
                      onPressed: bloc.onTapSettings,
                      icon: Icon(Icons.settings, color: textColor),
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
}
