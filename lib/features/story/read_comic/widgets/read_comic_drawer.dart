import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/features/story/read_comic/entities/comic_chapter_entity.dart';
import 'package:flutter_template/shared/widgets/scroll_bar/app_raw_scrollbar.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class ReadComicDrawer extends ConsumerWidget {
  const ReadComicDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.watch(BlocProvider.readComic);

    return ObsBuilder(
      streams: [
        bloc.isOpenDrawerSubject,
        bloc.comicChaptersSubject,
        bloc.currentChapterSubject,
      ],
      builder: (context) {
        final isOpen = bloc.isOpenDrawerSubject.value;
        final chapters = bloc.comicChaptersSubject.value;
        final currentChapter = bloc.currentChapterSubject.value;

        final screenWidth = MediaQuery.of(context).size.width;
        final drawerWidth = screenWidth * 0.8;

        return Stack(
          children: [
            IgnorePointer(
              ignoring: !isOpen,
              child: GestureDetector(
                onTap: bloc.onTapToggleDrawer,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 250),
                  opacity: isOpen ? 1.0 : 0.0,
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              top: 0,
              bottom: 0,
              left: isOpen ? 0 : -drawerWidth,
              width: drawerWidth,
              child: _DrawerContentWidget(
                isOpen: isOpen,
                chapters: chapters,
                currentChapter: currentChapter,
                bloc: bloc,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DrawerContentWidget extends StatefulWidget {
  final bool isOpen;
  final List<ComicChapterEntity> chapters;
  final ComicChapterEntity? currentChapter;
  final dynamic bloc;

  const _DrawerContentWidget({
    required this.isOpen,
    required this.chapters,
    required this.currentChapter,
    required this.bloc,
  });

  @override
  State<_DrawerContentWidget> createState() => _DrawerContentWidgetState();
}

class _DrawerContentWidgetState extends State<_DrawerContentWidget> {
  late final ScrollController _scrollController;
  late final ListController _listController;

  bool _showScrollBtn = false;
  bool _isArrowUp = false;
  double? _anchorOffset;
  bool _isJumping = false;

  // BIẾN LƯU TRẠNG THÁI ĐẢO NGƯỢC
  bool _isReversed = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _listController = ListController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_onScroll);
    });
  }

  @override
  void didUpdateWidget(covariant _DrawerContentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen && !oldWidget.isOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToCurrent(animate: false);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _listController.dispose();
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

  void _scrollToCurrent({bool animate = true}) {
    if (widget.chapters.isEmpty) return;

    // Lấy index gốc
    final originalIndex = widget.chapters.indexWhere(
      (c) => c.id == widget.currentChapter?.id,
    );
    if (originalIndex == -1) return;

    // THUẬT TOÁN ÁNH XẠ INDEX: Nếu đang đảo ngược thì tính lại vị trí thực tế trên danh sách hiển thị
    final targetIndex = _isReversed
        ? (widget.chapters.length - 1 - originalIndex)
        : originalIndex;

    _isJumping = true;
    if (_showScrollBtn) {
      setState(() {
        _showScrollBtn = false;
      });
    }

    if (animate) {
      _listController.animateToItem(
        index: targetIndex,
        scrollController: _scrollController,
        alignment: 0.5,
        duration: (_) => const Duration(milliseconds: 300),
        curve: (_) => Curves.easeInOut,
      );

      Future.delayed(const Duration(milliseconds: 350), () {
        if (mounted) {
          _anchorOffset = _scrollController.offset;
          _isJumping = false;
        }
      });
    } else {
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

  void _toggleReverse() {
    setState(() {
      _isReversed = !_isReversed;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrent(animate: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          color: Colors.black.withValues(alpha: 0.85),
          child: SafeArea(
            left: false,
            right: false,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Mục lục',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // NÚT ĐẢO CHIỀU (REVERSE) Ở ĐÂY
                          IconButton(
                            onPressed: _toggleReverse,
                            icon: Icon(
                              _isReversed
                                  ? Icons.keyboard_double_arrow_up_rounded
                                  : Icons.keyboard_double_arrow_down_rounded,
                              color: Colors.white,
                            ),
                            tooltip: 'Đảo ngược danh sách',
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.white24, height: 1),
                    Expanded(
                      child: AppRawScrollBar(
                        controller: _scrollController,
                        child: SuperListView.builder(
                          controller: _scrollController,
                          listController: _listController,
                          padding: EdgeInsets.zero,
                          itemCount: widget.chapters.length,
                          itemBuilder: (context, displayIndex) {
                            // THUẬT TOÁN ĐẢO CHIỀU ITEM: Lấy data thật dựa trên trạng thái _isReversed
                            final actualIndex = _isReversed
                                ? (widget.chapters.length - 1 - displayIndex)
                                : displayIndex;

                            final chapter = widget.chapters[actualIndex];
                            final isCurrent =
                                chapter.id == widget.currentChapter?.id;

                            return InkWell(
                              onTap: () {
                                widget.bloc.onTapChapterIndex(actualIndex);
                              },
                              child: Container(
                                color: isCurrent
                                    ? theme.primaryColor
                                    : Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        chapter.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: isCurrent
                                              ? FontWeight.w700
                                              : FontWeight.w400,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (isCurrent)
                                      const Icon(
                                        Icons.graphic_eq_rounded,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                // Nút định vị nổi
                Positioned(
                  bottom: 24,
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
                            onTap: () => _scrollToCurrent(animate: true),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                _isArrowUp
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_rounded,
                                color: theme.colorScheme.onPrimary,
                                size: 28,
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
        ),
      ),
    );
  }
}
