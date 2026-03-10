import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/features/story/read_comic/widgets/read_comic_content_page.dart';
import 'package:flutter_template/shared/widgets/gesture_detector/app_tap_and_scroll_detector.dart';
import 'package:flutter_template/shared/widgets/reading_view/vertical_reading_view.dart';

class ReadComicContent extends ConsumerWidget {
  const ReadComicContent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.readComic);
    return SafeArea(
      child: AppTapAndScrollDetector(
        onScroll: bloc.onMenuInvisible,
        onTap: bloc.onToggleMenuVisibility,
        child: ObsBuilder(
          streams: [bloc.comicChaptersSubject],
          builder: (context) {
            return VerticalReadingView(
              pageController: bloc.pageController,
              itemCount: bloc.comicChaptersSubject.value.length,
              onPageChanged: bloc.onPageChanged,
              itemBuilder: (context, index, controller) {
                final chapter = bloc.comicChaptersSubject.value[index];
                return ReadComicContentPage(
                  index: index,
                  isLastPage:
                      index == bloc.comicChaptersSubject.value.length - 1,
                  chapter: chapter,
                  controller: controller,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
