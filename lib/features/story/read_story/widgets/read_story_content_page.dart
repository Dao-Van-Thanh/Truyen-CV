import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/constants/constants.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/network_api/story/chapter/chapter_response.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/features/story/read_story/enum/read_theme_mode.dart';
import 'package:flutter_template/features/story/read_story/utils/read_story_util.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:flutter_template/shared/widgets/gesture_detector/app_gesture_detector.dart';

class ReadStoryContentPage extends ConsumerStatefulWidget {
  final ListChapterRes? listChapterItem;
  final ScrollController controller;
  const ReadStoryContentPage({
    super.key,
    required this.listChapterItem,
    required this.controller,
  });

  @override
  ConsumerState<ReadStoryContentPage> createState() =>
      _ReadStoryContentPageState();
}

class _ReadStoryContentPageState extends ConsumerState<ReadStoryContentPage>
    with AutomaticKeepAliveClientMixin {
  ChapterResponse? chapter;
  bool isLoading = true;
  late ScrollController _scrollController;
  late final networkApiService = ref.read(AppService.networkApi);
  late final bloc = ref.read(BlocProvider.readStory);

  Future<ChapterResponse?> _fetchChapter({required String chapterId}) async {
    final res = await networkApiService.storyRepository.getChapter(
      chapterId,
    );
    if (!mounted) return null;
    return res.whenOrNull<ChapterResponse?>(
      success: (data) {
        final chapter = data.data;
        return chapter;
      },
      error: (error) {
        logger.e('Failed to load chapter: $error');
        return null;
      },
    );
  }

  void _loadChapter() {
    setState(() => isLoading = true);
    _fetchChapter(chapterId: widget.listChapterItem?.id ?? '').then((value) {
      if (!mounted) return;
      setState(() {
        chapter = value;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadChapter();
    _scrollController = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final paragraphs = ReadStoryUtil.parseContent(
      chapter?.content ?? '',
      widget.listChapterItem?.name ?? '',
    );
    final t = context.t;
    return ObsBuilder(
      streams: [
        bloc.themeModeSubject,
      ],
      builder: (context) {
        final themeMode = bloc.themeModeSubject.value;
        if (chapter == null && isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (chapter == null && !isLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  t.readStory.loadingError,
                  style: TextStyle(
                    fontSize: 16,
                    color: themeMode.textColor,
                  ),
                ),
                SizedBoxConstants.s4,
                ElevatedButton(
                  onPressed: () {
                    _loadChapter();
                  },
                  child: Text(t.readStory.retry),
                ),
              ],
            ),
          );
        }

        return AppGestureDetector(
          onTap: () => bloc.toggleMenuVisibility(),
          behavior: HitTestBehavior.translucent,
          child: ListView.separated(
            itemCount: paragraphs.length,
            controller: _scrollController,
            padding: const EdgeInsets.all(8),
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return _buildParagraphItem(
                paragraphs[index],
                index,
                themeMode,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildParagraphItem(
    String content,
    int index,
    ReadThemeMode themeMode,
  ) {
    double fontSize = 17.0;
    final lineHeight = 1.5;
    final color = themeMode.textColor;
    FontWeight fontWeight = FontWeight.w400;
    TextAlign textAlign = TextAlign.justify;

    if (index == 0) {
      fontSize += 2.0;
      fontWeight = FontWeight.w600;
      textAlign = TextAlign.center;
    }

    return Text(
      content,
      style: TextStyle(
        fontSize: fontSize,
        height: lineHeight,
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
