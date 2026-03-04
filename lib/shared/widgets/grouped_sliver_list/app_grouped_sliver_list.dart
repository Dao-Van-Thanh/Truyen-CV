import 'package:flutter/material.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/widgets/load_more/load_more_list.dart';
import 'package:flutter_template/shared/widgets/refresh_indicator/app_refresh_indicator.dart';
import 'package:rxdart/rxdart.dart';

class AppGroupedSliverList<T> extends StatefulWidget {
  const AppGroupedSliverList({
    super.key,
    required this.data,
    required this.groupBy,
    required this.titleBuilder,
    required this.itemBuilder,
    this.separatorBuilder,
    this.padding = EdgeInsets.zero,
    this.controller,
    this.onLoadMore,
    this.isLastPage = true,
    this.footerBuilder,
    this.onRefresh,
  });

  final List<T> data;
  final String Function(T item) groupBy;

  final Future<void> Function()? onRefresh;
  final Widget Function(BuildContext context, String title) titleBuilder;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  final EdgeInsetsGeometry padding;
  final ScrollController? controller;

  final Future<void> Function()? onLoadMore;
  final bool isLastPage;

  final Widget Function(BuildContext context)? footerBuilder;

  @override
  State<AppGroupedSliverList<T>> createState() =>
      _AppGroupedSliverListState<T>();
}

class _AppGroupedSliverListState<T> extends State<AppGroupedSliverList<T>> {
  late Map<String, List<T>> _groupedData;
  late ScrollController _scrollController;

  final _isLoadMoreSubject = BehaviorSubject<bool>.seeded(false);

  @override
  void initState() {
    super.initState();
    _groupedData = _groupData(widget.data);
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant AppGroupedSliverList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.data != widget.data) {
      _groupedData = _groupData(widget.data);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    _isLoadMoreSubject.close();
    super.dispose();
  }

  void _onScroll() async {
    if (widget.onLoadMore == null || widget.isLastPage) return;
    if (_isLoadMoreSubject.value) return;
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    const delta = 200.0;

    if (maxScroll - currentScroll <= delta) {
      _isLoadMoreSubject.value = true;

      await widget.onLoadMore?.call();

      if (!mounted) return;

      _isLoadMoreSubject.value = false;
    }
  }

  Map<String, List<T>> _groupData(List<T> data) {
    final Map<String, List<T>> grouped = {};

    for (final item in data) {
      final key = widget.groupBy(item);
      grouped.putIfAbsent(key, () => []).add(item);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return AppRefreshIndicator(
      onRefresh: widget.onRefresh,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          ..._groupedData.entries.map(
            (entry) => _buildGroup(
              context: context,
              groupKey: entry.key,
              group: entry.value,
            ),
          ),
          if (widget.footerBuilder != null)
            SliverToBoxAdapter(
              child: widget.footerBuilder!(context),
            )
          else
            SliverToBoxAdapter(
              child: ObsBuilder(
                streams: [_isLoadMoreSubject],
                builder: (context) {
                  return _buildFooter(context);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    if (widget.onLoadMore == null) {
      return const SizedBox.shrink();
    }

    if (_isLoadMoreSubject.value) {
      return const LoadMoreList();
    }

    if (widget.isLastPage) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            context.t.libraryScreen.historyFooterEnd,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildGroup({
    required BuildContext context,
    required String groupKey,
    required List<T> group,
  }) {
    final hasSeparator = widget.separatorBuilder != null;

    final childCount =
        hasSeparator ? 1 + group.length * 2 - 1 : 1 + group.length;

    return SliverPadding(
      padding: widget.padding,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index == 0) {
              return widget.titleBuilder(context, groupKey);
            }

            if (hasSeparator) {
              final adjustedIndex = index - 1;
              final itemIndex = adjustedIndex ~/ 2;

              if (adjustedIndex.isEven) {
                final item = group[itemIndex];
                return widget.itemBuilder(context, item);
              } else {
                return widget.separatorBuilder!(context, itemIndex);
              }
            } else {
              final itemIndex = index - 1;
              final item = group[itemIndex];
              return widget.itemBuilder(context, item);
            }
          },
          childCount: childCount,
        ),
      ),
    );
  }
}
