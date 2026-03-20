import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/constants/constants.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/features/story/read_comic/entities/comic_chapter_entity.dart';
import 'package:flutter_template/features/story/read_comic/widgets/comic_render_image.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/widgets/gesture_detector/app_gesture_detector.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ReadComicContentPage extends ConsumerStatefulWidget {
  final int index;
  final ComicChapterEntity chapter;
  final AutoScrollController controller;
  final bool isLastPage;
  const ReadComicContentPage({
    super.key,
    required this.index,
    required this.chapter,
    required this.controller,
    required this.isLastPage,
  });

  @override
  ConsumerState<ReadComicContentPage> createState() =>
      _ReadComicContentPageState();
}

class _ReadComicContentPageState extends ConsumerState<ReadComicContentPage>
    with WidgetsBindingObserver {
  late AutoScrollController _scrollController;
  late final networkApiService = ref.read(AppService.networkApi);
  late final bloc = ref.read(BlocProvider.readComic);
  final ScrollController _horizontalScrollController = ScrollController();
  late final VoidCallback _scrollListener;
  bool _hasScrollListener = false;

  double _offSet = 0.0;
  bool _isInitScrollDone = false;
  double _zoomStart = 1.0;

  Future<void> _onWillPop(BuildContext context, Object? result) async {
    final isCurrentPage = bloc.isCurrentPage(widget.chapter.id);
    if (!isCurrentPage) return;

    if (result != 'FORCE_EXIT') {
      final canExit = bloc.onAfterExitReadStory();
      if (!canExit) return;
    }

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listenScroll();
    });
  }

  void _listenScroll() {
    _scrollListener = () {
      _offSet = _scrollController.offset;
    };
    _scrollController.addListener(_scrollListener);
    _hasScrollListener = true;
  }

  void _removeScrollListener() {
    if (!_hasScrollListener) return;
    _scrollController.removeListener(_scrollListener);
    _hasScrollListener = false;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _handleUpsertLocal();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _horizontalScrollController.dispose();
    super.dispose();
  }

  Future<void> _handleUpsertLocal() async {
    final isCurrentPage = bloc.isCurrentPage(widget.chapter.id);
    if (!isCurrentPage) return;
    await bloc.upsertBookLocal(
      chapterId: widget.chapter.id,
      scrollOffset: _offSet,
      listChapters: bloc.comicChaptersSubject.value.map((e) {
        return e.toListChapterEntity();
      }).toList(),
      lastReadTime: DateTime.now().toIso8601String(),
    );
    _removeScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _onWillPop(context, result);
      },
      child: Builder(
        builder: (context) {
          final chapterData = widget.chapter;
          if (widget.chapter.pages.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (widget.chapter.id != bloc.selectedChapterId ||
                _isInitScrollDone) {
              return;
            }
            _scrollController.jumpTo(bloc.scrollOffset);
            _isInitScrollDone = true;
          });

          return StreamBuilder<double>(
            stream: bloc.zoomSubject.stream.distinct(),
            initialData: bloc.zoomSubject.value,
            builder: (context, snapshot) {
              final zoom = snapshot.data ?? 1.0;
              final viewportWidth = MediaQuery.sizeOf(context).width;
              final contentWidth = viewportWidth * zoom;

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onDoubleTap: () {
                  bloc.setZoom(1.0);
                  if (_horizontalScrollController.hasClients) {
                    _horizontalScrollController.jumpTo(0);
                  }
                },
                onScaleStart: (_) {
                  _zoomStart = bloc.zoomSubject.value;
                },
                onScaleUpdate: (details) {
                  // Apply one zoom level to the whole chapter content.
                  bloc.setZoom(_zoomStart * details.scale);
                },
                child: SingleChildScrollView(
                  controller: _horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  physics: zoom > 1.0
                      ? const ClampingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  child: SizedBox(
                    width: contentWidth,
                    child: ListView.builder(
                      itemCount: chapterData.pages.length + 1,
                      controller: _scrollController,
                      physics: const NeverScrollableScrollPhysics(),
                      cacheExtent: 3000,
                      itemBuilder: (context, index) {
                        if (index == chapterData.pages.length) {
                          return _buildChapterEndFooter();
                        }

                        return AutoScrollTag(
                          key: Key('paragraph_$index'),
                          index: index,
                          controller: _scrollController,
                          child: _buildItem(
                            url: chapterData.pages[index].url,
                            isLastItem: index == chapterData.pages.length - 1,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildNextChapterDivider() {
    return Container(
      height: 100,
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.keyboard_double_arrow_down_rounded,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              'Chương tiếp theo',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({
    required String url,
    required bool isLastItem,
  }) {
    return ComicReaderImage(
      imageUrl: url,
    );
  }

  Widget _buildChapterEndFooter() {
    if (widget.isLastPage) {
      return Center(
        child: Column(
          children: [
            SizedBoxConstants.s12,
            Text(
              '--- ${context.t.readStory.endChapter.toUpperCase()} ---',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBoxConstants.s12,
            AppGestureDetector(
              onTap: () {
                bloc.onTapLoadNewChapter();
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsetsConstants.vertical8 +
                    EdgeInsetsConstants.horizontal12,
                child: Text(
                  context.t.readStory.checkNewChapters,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return _buildNextChapterDivider();
  }
}
