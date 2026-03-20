import 'package:flutter/material.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/story_entity.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/widgets/story_list/enum/story_list_type.dart';
import 'package:flutter_template/shared/widgets/story_list/widgets/story_grid_item.dart';
import 'package:flutter_template/shared/widgets/story_list/widgets/story_list_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StoryList extends StatefulWidget {
  final PagingController<int, StoryEntity> pagingController;
  final StoryListType listType;
  final void Function(StoryEntity item) onTapItem;

  const StoryList({
    super.key,
    required this.pagingController,
    required this.listType,
    required this.onTapItem,
  });

  @override
  State<StoryList> createState() => _StoryListState();
}

class _StoryListState extends State<StoryList> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final shouldShow =
        _scrollController.offset > MediaQuery.of(context).size.height;
    if (_showScrollToTop != shouldShow) {
      setState(() => _showScrollToTop = shouldShow);
    }
  }

  Widget _loader() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SizedBox(
          width: 20,
          height: 20,
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final t = context.t;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(t.story.noData),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              widget.pagingController.refresh();
            },
            child: Text(t.story.reload),
          ),
        ],
      ),
    );
  }

  PagedChildBuilderDelegate<StoryEntity> _buildDelegate() {
    return PagedChildBuilderDelegate<StoryEntity>(
      itemBuilder: (context, item, index) {
        if (widget.listType == StoryListType.grid) {
          return StoryGridItem(
            story: item,
            onTap: () => widget.onTapItem(item),
          );
        }
        return StoryListItem(
          story: item,
          isCompact: widget.listType == StoryListType.listCompact,
          onTap: () => widget.onTapItem(item),
        );
      },
      firstPageProgressIndicatorBuilder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
      newPageProgressIndicatorBuilder: (_) => _loader(),
      noItemsFoundIndicatorBuilder: (_) => _buildEmptyState(),
      firstPageErrorIndicatorBuilder: (_) => _buildEmptyState(),
      newPageErrorIndicatorBuilder: (_) => _newPageErrorIndicatorBuilder(),
    );
  }

  Widget _newPageErrorIndicatorBuilder() {
    final t = context.t;
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => widget.pagingController.fetchNextPage(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.refresh_rounded,
              color: colorScheme.primary,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              t.story.reload,
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    switch (widget.listType) {
      case StoryListType.grid:
        return PagingListener(
          controller: widget.pagingController,
          builder: (context, state, fetchNextPage) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;

                final crossAxisCount = switch (width) {
                  >= 900 => 6,
                  >= 720 => 5,
                  >= 520 => 4,
                  _ => 3,
                };

                const padding = 12.0;
                const spacing = 10.0;

                final availableWidth =
                    (width - padding * 2) - spacing * (crossAxisCount - 1);
                final itemWidth = availableWidth / crossAxisCount;

                final imageHeight = itemWidth * (4 / 3);
                final contentHeight = itemWidth < 120 ? 74.0 : 88.0;
                final heightItem = imageHeight + contentHeight;

                return PagedGridView<int, StoryEntity>(
                  scrollController: _scrollController,
                  state: state,
                  fetchNextPage: fetchNextPage,
                  padding: const EdgeInsets.all(padding),
                  cacheExtent: 500,
                  addRepaintBoundaries: true,
                  addAutomaticKeepAlives: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                    mainAxisExtent: heightItem,
                  ),
                  builderDelegate: _buildDelegate(),
                );
              },
            );
          },
        );
      case StoryListType.list:
      case StoryListType.listCompact:
        return PagingListener(
          controller: widget.pagingController,
          builder: (context, state, fetchNextPage) {
            return PagedListView<int, StoryEntity>(
              scrollController: _scrollController,
              fetchNextPage: fetchNextPage,
              state: state,
              cacheExtent: 500,
              addRepaintBoundaries: true,
              addAutomaticKeepAlives: true,
              builderDelegate: _buildDelegate(),
            );
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onVerticalDragDown: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onTapDown: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: RefreshIndicator(
            onRefresh: () async {
              widget.pagingController.refresh();
            },
            child: _buildListView(),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: _showScrollToTop
                ? FloatingActionButton(
                    heroTag: widget.key,
                    onPressed: () {
                      _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    mini: true,
                    child: const Icon(Icons.arrow_upward),
                  )
                : const SizedBox(key: ValueKey('empty')),
          ),
        ),
      ],
    );
  }
}
