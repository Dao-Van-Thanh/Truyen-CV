import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/dependency/network_api/story/filter/story_filter_response.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StoryGridList extends StatefulWidget {
  final List<StoryModel> stories;
  final bool isLoading;
  final bool isFirstLoad;
  final bool hasMore;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;

  const StoryGridList({
    super.key,
    required this.stories,
    required this.isLoading,
    required this.isFirstLoad,
    required this.hasMore,
    required this.onRefresh,
    required this.onLoadMore,
  });

  @override
  State<StoryGridList> createState() => _StoryGridListState();
}

class _StoryGridListState extends State<StoryGridList> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (widget.hasMore && !widget.isLoading) {
        widget.onLoadMore();
      }
    }
    // Show/hide scroll to top button
    if (_scrollController.offset > MediaQuery.of(context).size.height) {
      if (!_showScrollToTop) {
        setState(() {
          _showScrollToTop = true;
        });
      }
    } else {
      if (_showScrollToTop) {
        setState(() {
          _showScrollToTop = false;
        });
      }
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
              onPressed: () => widget.onRefresh(),
              child: Text(t.story.reload),
            )
          ],
        ),
      );
    }

    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: height * 0.29,
            ),
            itemCount: widget.stories.length + (widget.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == widget.stories.length) {
                return Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                  ),
                );
              }

              final story = widget.stories[index];
              return _buildStoryItem(story);
            },
          ),
        ),
        // button scroll to top
        Positioned(
          bottom: 16,
          right: 16,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: child,
            ),
            child: _showScrollToTop
                ? Positioned(
                    key: const ValueKey('scrollToTopBtn'),
                    bottom: 16,
                    right: 16,
                    child: FloatingActionButton(
                      onPressed: () {
                        _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      mini: true,
                      child: const Icon(Icons.arrow_upward),
                    ),
                  )
                : const SizedBox.shrink(key: ValueKey('empty')),
          ),
        ),
      ],
    );
  }

  Widget _buildStoryItem(StoryModel story) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        shape: BoxShape.rectangle,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 3 / 4,
            child: CachedNetworkImage(
              imageUrl: story.thumb ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: isDark ? Colors.grey[800] : Colors.grey[300],
                alignment: Alignment.center,
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: theme.colorScheme.primary,
                  size: 30,
                ),
              ),
              errorWidget: (context, url, error) {
                return Container(
                  color: isDark ? Colors.grey[800] : Colors.grey[300],
                  alignment: Alignment.center,
                  child: const Icon(Icons.error, size: 20),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      story.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '★${story.rating ?? 0}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            size: 12,
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            story.viewed ?? '0',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.6),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    story.process ?? '',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
