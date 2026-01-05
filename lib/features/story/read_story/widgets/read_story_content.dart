import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/features/story/read_story/widgets/read_story_content_page.dart';
import 'package:flutter_template/shared/widgets/reading_view/vertical_reading_view.dart';

class ReadStoryContent extends ConsumerWidget {
  const ReadStoryContent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.readStory);
    return SafeArea(
      child: ObsBuilder(
        streams: [bloc.listChapterSubject],
        builder: (context) {
          return VerticalReadingView(
            pageController: bloc.pageController,
            itemCount: bloc.listChapterSubject.value.length,
            onPageChanged: bloc.onPageChanged,
            itemBuilder: (context, index, controller) {
              final chapter = bloc.listChapterSubject.value[index];
              return ReadStoryContentPage(
                index: index,
                isLastPage: index == bloc.listChapterSubject.value.length - 1,
                listChapterItem: chapter,
                controller: controller,
              );
            },
          );
        },
      ),
    );
  }
}
