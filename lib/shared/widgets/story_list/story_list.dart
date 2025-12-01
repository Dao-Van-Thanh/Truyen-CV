import 'package:flutter/material.dart';
import 'package:flutter_template/dependency/network_api/story/filter/story_filter_response.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/widgets/story_list/enum/story_list_type.dart';
import 'package:flutter_template/shared/widgets/story_list/widgets/story_grid_item.dart';
import 'package:flutter_template/shared/widgets/story_list/widgets/story_list_item.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StoryList extends StatefulWidget {
  final List<StoryModel> stories;
  final bool isLoading;
  final bool isFirstLoad;
  final bool hasMore;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;
  final StoryListType listType;

  const StoryList({
    super.key,
    required this.stories,
    required this.isLoading,
    required this.isFirstLoad,
    required this.hasMore,
    required this.onRefresh,
    required this.onLoadMore,
    required this.listType,
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
    final pos = _scrollController.position;

    if (pos.pixels >= pos.maxScrollExtent - 200 &&
        widget.hasMore &&
        !widget.isLoading) {
      widget.onLoadMore();
    }

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

  Widget _buildGrid(double heightItem) {
    final itemCount = widget.stories.length + (widget.hasMore ? 1 : 0);

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(12),
      cacheExtent: 500,
      addRepaintBoundaries: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: heightItem,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index >= widget.stories.length) return _loader();
        return StoryGridItem(story: widget.stories[index]);
      },
    );
  }

  Widget _buildList() {
    final itemCount = widget.stories.length + (widget.hasMore ? 1 : 0);

    return ListView.builder(
      controller: _scrollController,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index >= widget.stories.length) return _loader();
        return StoryListItem(
          story: widget.stories[index],
          isCompact: widget.listType == StoryListType.listCompact,
        );
      },
    );
  }

  Widget _buildListView() {
    switch (widget.listType) {
      case StoryListType.grid:
        final heightItem = MediaQuery.of(context).size.height * 0.29;
        return _buildGrid(heightItem);
      case StoryListType.list:
      case StoryListType.listCompact:
        return _buildList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    if (widget.isFirstLoad && widget.stories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!widget.isFirstLoad && widget.stories.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(t.story.noData),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: widget.onRefresh,
              child: Text(t.story.reload),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: _buildListView(),
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
