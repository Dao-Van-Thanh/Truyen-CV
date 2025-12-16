import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/network_api/story/chapter/chapter_response.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/features/story/read_story/extension/read_story_local_extension.dart';
import 'package:flutter_template/features/story/read_story/model/config_story_model.dart';
import 'package:flutter_template/shared/widgets/gesture_detector/app_gesture_detector.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ReadStoryContentPage extends ConsumerStatefulWidget {
  final int index;
  final ListChapterRes? listChapterItem;
  final AutoScrollController controller;
  const ReadStoryContentPage({
    super.key,
    required this.index,
    required this.listChapterItem,
    required this.controller,
  });

  @override
  ConsumerState<ReadStoryContentPage> createState() =>
      _ReadStoryContentPageState();
}

class _ReadStoryContentPageState extends ConsumerState<ReadStoryContentPage>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  late AutoScrollController _scrollController;
  late final networkApiService = ref.read(AppService.networkApi);
  late final bloc = ref.read(BlocProvider.readStory);

  double _offSet = 0.0;

  bool get isCurrentChapter =>
      widget.listChapterItem?.id == bloc.args.selectedChapterId;

  ChapterResponse? get _chapterFromCache {
    final chapterId = widget.listChapterItem?.id ?? '';
    return bloc.chaptersMapSubject.value[chapterId];
  }

  Future<void> _onWillPop(BuildContext context) async {
    final isCurrentPage = bloc.isCurrentPage(widget.listChapterItem?.id);
    if (!isCurrentPage) return;
    await _handleUpsertLocal();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollController = widget.controller;
    _listenScroll();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (widget.listChapterItem?.id != bloc.args.selectedChapterId) return;
    //   _scrollController.jumpTo(bloc.args.scrollOffset);
    // });
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _handleUpsertLocal();
      bloc.saveConfigLocal(bloc.configStorySubject.value);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    if (_scrollController.hasClients) {
      _scrollController.dispose();
    }
  }

  Future<void> _handleUpsertLocal() async {
    final isCurrentPage = bloc.isCurrentPage(widget.listChapterItem?.id);
    if (!isCurrentPage) return;
    await bloc.upsertBookLocal(
      chapterId: widget.listChapterItem?.id ?? '',
      scrollOffset: _offSet,
      lastReadTime: DateTime.now().toIso8601String(),
    );
    _removeScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _onWillPop(context);
      },
      child: ObsBuilder(
        streams: [
          bloc.configStorySubject,
          bloc.chaptersMapSubject,
        ],
        builder: (context) {
          final config = bloc.configStorySubject.value;
          final chapterData = _chapterFromCache;
          if (chapterData == null) {
            return const Center(child: CircularProgressIndicator());
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (widget.listChapterItem?.id != bloc.args.selectedChapterId) {
              return;
            }
            _scrollController.jumpTo(bloc.args.scrollOffset);
          });

          return AppGestureDetector(
            onTap: () => bloc.toggleMenuVisibility(),
            behavior: HitTestBehavior.translucent,
            child: ListView.separated(
              itemCount: chapterData.paragraphs.length,
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return AutoScrollTag(
                  key: Key('paragraph_$index'),
                  index: index,
                  controller: _scrollController,
                  child: _buildParagraphItem(
                    isHightLight: false,
                    content: chapterData.paragraphs[index],
                    index: index,
                    config: config,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildParagraphItem({
    required bool isHightLight,
    required String content,
    required int index,
    required ConfigStoryModel config,
  }) {
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: isHightLight ? color.withValues(alpha: 0.3) : Colors.transparent,
      child: Text(
        content,
        style: TextStyle(
          fontSize: fontSize,
          height: lineHeight,
          color: color,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
        ),
        textAlign: textAlign,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
