import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/constants/constants.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/network_api/story/chapter/chapter_response.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/features/story/read_story/extension/read_story_local_extension.dart';
import 'package:flutter_template/features/story/read_story/model/config_story_model.dart';
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

  double _offSet = 0.0;

  bool get isCurrentChapter =>
      widget.listChapterItem?.id == bloc.args.selectedChapterId;

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

  Future<void> _loadChapter() async {
    setState(() => isLoading = true);
    final res =
        await _fetchChapter(chapterId: widget.listChapterItem?.id ?? '');
    if (!mounted) return;
    setState(() {
      chapter = res;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller;
    _listenScroll();
    _loadChapter().then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.listChapterItem?.id != bloc.args.selectedChapterId) return;
        _scrollController.jumpTo(bloc.args.scrollOffset);
      });
    });
  }

  void _listenScroll() {
    _scrollController.addListener(() {
      _offSet = _scrollController.offset;
    });
  }

  void _removeScrollListener() {
    _scrollController.removeListener(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _handleUpsertLocal();
    if (_scrollController.hasClients) {
      _scrollController.dispose();
    }
  }

  void _handleUpsertLocal() {
    final isCurrentPage = bloc.isCurrentPage(widget.listChapterItem?.id);
    if (!isCurrentPage) return;
    bloc.upsertBookLocal(
      chapterId: widget.listChapterItem?.id ?? '',
      scrollOffset: _offSet,
    );
    _removeScrollListener();
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
        bloc.configStorySubject,
      ],
      builder: (context) {
        final config = bloc.configStorySubject.value;
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
                    color: config.themeMode.textColor,
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
            padding: const EdgeInsets.all(16),
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return _buildParagraphItem(
                paragraphs[index],
                index,
                config,
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
    ConfigStoryModel config,
  ) {
    double fontSize = config.fontSize;
    final lineHeight = config.lineHeight;
    final color = config.themeMode.textColor;
    FontWeight fontWeight = FontWeight.w400;
    TextAlign textAlign = TextAlign.justify;
    final fontFamily = config.fontFamily;

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
        fontFamily: fontFamily,
      ),
      textAlign: textAlign,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
