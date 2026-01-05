import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/constants/constants.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/utilities/debounce.dart';
import 'package:flutter_template/shared/widgets/cache_network_image/app_cache_network_image.dart';
import 'package:flutter_template/shared/widgets/gesture_detector/app_gesture_detector.dart';
import 'package:flutter_template/shared/widgets/page_view/app_page_view.dart';
import 'package:flutter_template/shared/widgets/scroll_bar/app_raw_scrollbar.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class ReadStoryDrawer extends ConsumerStatefulWidget {
  final List<ListChapterRes> listChapter;
  const ReadStoryDrawer({super.key, required this.listChapter});

  @override
  ConsumerState<ReadStoryDrawer> createState() => _ReadStoryDrawerState();
}

class _ReadStoryDrawerState extends ConsumerState<ReadStoryDrawer> {
  late final bloc = ref.watch(BlocProvider.readStory);
  late final _listChapter = widget.listChapter;

  late final _scrollController = AutoScrollController();
  late final _listController = ListController();

  final Debounce _preloadDebounce = Debounce(milliseconds: 300);

  StreamSubscription? _chapterSubscription;

  bool _showScrollBtn = false;
  bool _isArrowUp = false;
  double? _anchorOffset;
  bool _isJumping = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_onScroll);
      _anchorOffset = _scrollController.offset;
      _chapterSubscription =
          bloc.currentListChapterItemSubject.listen((currentChapter) {
        _preloadDebounce.run(() {
          if (!mounted) return;
          _jumpToCurrentChapter();
        });
      });
    });
  }

  @override
  void didUpdateWidget(covariant ReadStoryDrawer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.listChapter != widget.listChapter) {
      setState(() {
        _listChapter.clear();
        _listChapter.addAll(widget.listChapter);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _listController.dispose();
    _chapterSubscription?.cancel();
    _preloadDebounce.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isJumping || _anchorOffset == null) return;

    final currentOffset = _scrollController.offset;
    final diff = currentOffset - _anchorOffset!;

    const threshold = 300.0;

    if (diff.abs() > threshold) {
      final shouldGoUp = diff > 0;

      if (!_showScrollBtn || _isArrowUp != shouldGoUp) {
        setState(() {
          _showScrollBtn = true;
          _isArrowUp = shouldGoUp;
        });
      }
    } else {
      if (_showScrollBtn) {
        setState(() {
          _showScrollBtn = false;
        });
      }
    }
  }

  void _jumpToCurrentChapter() {
    final index = _getCurrentChapterIndex();
    if (index != -1) {
      _isJumping = true;
      if (_showScrollBtn) {
        setState(() {
          _showScrollBtn = false;
        });
      }

      final targetIndex = index * 2;

      _listController.jumpToItem(
        index: targetIndex,
        scrollController: _scrollController,
        alignment: 0.5,
      );

      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _anchorOffset = _scrollController.offset;
          _isJumping = false;
        }
      });
    }
  }

  int _getCurrentChapterIndex() {
    final currentChapter = bloc.currentListChapterItemSubject.value;
    final index = _listChapter.indexWhere((e) => e.id == currentChapter?.id);
    return index;
  }

  @override
  Widget build(BuildContext context) {
    final drawerWidth = MediaQuery.of(context).size.width * 0.9;
    final theme = Theme.of(context);

    return ObsBuilder(
      streams: [
        bloc.configStorySubject,
        bloc.currentListChapterItemSubject,
      ],
      builder: (context) {
        final config = bloc.configStorySubject.value;
        final backgroundColor = config.themeMode.backgroundColor;
        final textColor = config.themeMode.textColor;
        final currentChapterIndex = _getCurrentChapterIndex();

        return Drawer(
          width: drawerWidth,
          backgroundColor: backgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(0)),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    AppGestureDetector(
                      onTap: bloc.onTapNextStoryDetail,
                      child: Padding(
                        padding: EdgeInsetsConstants.horizontal16,
                        child: _drawerHeader(textColor),
                      ),
                    ),
                    Expanded(
                      child: AppPageView(
                        isScrollable: true,
                        dividerColor: Colors.transparent,
                        actions: [SizedBoxConstants.s16],
                        leading: SizedBoxConstants.s16,
                        indicatorColor: textColor,
                        items: [
                          AppPageViewItems(
                            label: context.t.storyDetail.tableOfContents,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: textColor),
                            child: AppRawScrollBar(
                              controller: _scrollController,
                              child: SuperListView.separated(
                                controller: _scrollController,
                                listController: _listController,
                                itemCount: _listChapter.length,
                                separatorBuilder: (_, i) {
                                  final isHighlight = i == currentChapterIndex;
                                  return Divider(
                                    height: 1,
                                    color: isHighlight
                                        ? theme.dividerColor
                                        : theme.dividerColor
                                            .withValues(alpha: 0.3),
                                  );
                                },
                                itemBuilder: (context, index) {
                                  final chapter = _listChapter[index];
                                  return AutoScrollTag(
                                    key: Key('chapter_drawer_$index'),
                                    controller: _scrollController,
                                    index: index,
                                    child: _buildItem(
                                      chapter.name ?? '',
                                      highlight: index == currentChapterIndex,
                                      textColor: textColor,
                                      onTap: () {
                                        bloc.onTapToggleDrawer();
                                        bloc.onTaoNextPageToIndex(index);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _showScrollBtn ? 1.0 : 0.0,
                      child: IgnorePointer(
                        ignoring: !_showScrollBtn,
                        child: Material(
                          color: theme.colorScheme.primary,
                          elevation: 4,
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: _jumpToCurrentChapter,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                _isArrowUp
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_rounded,
                                color: theme.colorScheme.onPrimary,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _drawerHeader(Color textColor) {
    return ObsBuilder(
      streams: [bloc.storyDetailSubject],
      builder: (context) {
        if (bloc.storyDetailSubject.value == null) {
          return const SizedBox.shrink();
        }
        final detail = bloc.storyDetailSubject.value!;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: AppCacheNetworkImage(
                  imageUrl: detail.thumb ?? '',
                  width: 50,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      detail.name ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: textColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      detail.author ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: textColor),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => bloc.onTapRefreshChapter(),
                icon: Icon(Icons.refresh_rounded, color: textColor),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItem(
    String chapterName, {
    required VoidCallback? onTap,
    required bool highlight,
    required Color textColor,
  }) {
    return AppGestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsetsConstants.vertical12 + EdgeInsetsConstants.horizontal20,
        child: Text(
          chapterName,
          style: TextStyle(
            fontSize: 16,
            fontStyle: highlight ? FontStyle.italic : FontStyle.normal,
            fontWeight: highlight ? FontWeight.w800 : FontWeight.w400,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
