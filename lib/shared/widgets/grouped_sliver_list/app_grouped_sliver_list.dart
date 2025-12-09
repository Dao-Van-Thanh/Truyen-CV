import 'package:flutter/material.dart';
import 'package:flutter_template/constants/size_box.dart';
import 'package:flutter_template/shared/widgets/detector/content_height_detector.dart';

class AppGroupedSliverList<T> extends StatefulWidget {
  final List<T> data;
  final String Function(T item) groupBy;
  final Widget Function(BuildContext context, String title) titleBuilder;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final bool isShowFooter;
  final Future<void> Function()? onLoadMore;
  final Widget Function(BuildContext context)? buildFooter;

  final Axis scrollDirection;
  final bool reverse;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final ScrollController? controller;
  final bool isLoadMore;
  final bool isLastPage;
  final EdgeInsetsGeometry padding;
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  const AppGroupedSliverList({
    super.key,
    required this.data,
    required this.groupBy,
    required this.titleBuilder,
    required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.physics,
    this.shrinkWrap = false,
    this.controller,
    this.isLoadMore = false,
    this.isLastPage = false,
    this.isShowFooter = true,
    this.padding = EdgeInsets.zero,
    this.separatorBuilder,
    this.onLoadMore,
    this.buildFooter,
  });

  @override
  State<AppGroupedSliverList<T>> createState() =>
      _AppGroupedSliverListState<T>();
}

class _AppGroupedSliverListState<T> extends State<AppGroupedSliverList<T>> {
  late Map<String, List<T>> groupedData;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    groupedData = _groupData();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(AppGroupedSliverList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      setState(() {
        groupedData = _groupData();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      const delta = 200.0; // Trigger khi còn 200px nữa đến cuối

      if (maxScroll - currentScroll <= delta) {
        if (!widget.isLoadMore && !widget.isLastPage) {
          widget.onLoadMore?.call();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      controller: _scrollController,
      slivers: groupedData.entries.map(
        (entry) {
          return _buildGroupedSlivers(
            context: context,
            groupKey: entry.key,
            group: entry.value,
          );
        },
      ).toList()
        ..addAll(
          widget.isShowFooter
              ? [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return AppContentHeightDetector(
                          buildFooter: widget.buildFooter,
                          scrollController: _scrollController,
                          builder: (context, buildEndOfList, isTaller) {
                            if (!isTaller) return SizedBoxConstants.shrink;

                            if (widget.isLastPage) {
                              return buildEndOfList.call(widget.isLoadMore);
                            }

                            return SizedBoxConstants.shrink;
                          },
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ]
              : [],
        ),
    );
  }

  Map<String, List<T>> _groupData() {
    final Map<String, List<T>> grouped = {};
    for (final item in widget.data) {
      final key = widget.groupBy(item);
      if (grouped.containsKey(key)) {
        grouped[key]!.add(item);
      } else {
        grouped[key] = [item];
      }
    }
    return grouped;
  }

  Widget _buildGroupedSlivers({
    required BuildContext context,
    required String groupKey,
    required List<T> group,
  }) {
    final bool hasSeparator = widget.separatorBuilder != null;

    // Tính toán số lượng phần tử (childCount)
    final int childCount = hasSeparator
        ? 1 + group.length * 2 - 1 // 1 cho title, xen kẽ item và separator
        : 1 + group.length; // 1 cho title, còn lại là các item

    return SliverPadding(
      padding: widget.padding,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index == 0) {
              // Vị trí đầu tiên là title
              return KeyedSubtree(
                key: ValueKey('title-$groupKey'),
                child: widget.titleBuilder(context, groupKey),
              );
            }

            if (hasSeparator) {
              // Với separator, các index lẻ là item, chẵn là separator
              final int adjustedIndex = index - 1;
              final int itemIndex = adjustedIndex ~/ 2;

              if (adjustedIndex.isEven) {
                // Build item
                final item = group[itemIndex];
                return KeyedSubtree(
                  key: ValueKey('item-$groupKey-$itemIndex'),
                  child: widget.itemBuilder(context, item),
                );
              } else {
                // Build separator
                return KeyedSubtree(
                  key: ValueKey('sep-$groupKey-$itemIndex'),
                  child: widget.separatorBuilder!(context, itemIndex),
                );
              }
            } else {
              // Không có separator, chỉ build item
              final int itemIndex = index - 1;
              final item = group[itemIndex];
              return KeyedSubtree(
                key: ValueKey('item-$groupKey-$itemIndex'),
                child: widget.itemBuilder(context, item),
              );
            }
          },
          childCount: childCount,
        ),
      ),
    );
  }
}
