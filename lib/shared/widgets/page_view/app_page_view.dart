import 'package:flutter/material.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';

class AppPageView extends StatefulWidget {
  final List<AppPageViewItems> items;
  final bool isScrollable;
  final bool isScrollTabView;
  final int initPageView;
  final Function(int index)? onPageChanged;

  const AppPageView({
    super.key,
    required this.items,
    this.initPageView = 0,
    this.isScrollable = false,
    this.isScrollTabView = true,
    this.onPageChanged,
  });

  @override
  State<AppPageView> createState() => AppPageViewState();
}

class AppPageViewState extends State<AppPageView>
    with SingleTickerProviderStateMixin {
  final currentPage = ValueNotifier<int>(0);
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.items.length, vsync: this);
    _tabController?.addListener(_handleTabSelection);
    _tabController?.animateTo(widget.initPageView);
    currentPage.value = widget.initPageView;
  }

  void _handleTabSelection() {
    if (_tabController == null) return;
    currentPage.value = _tabController!.index;
    widget.onPageChanged?.call(_tabController!.index);
  }

  void changeTab({int index = 0}) {
    _tabController?.animateTo(index);
    currentPage.value = index;
  }

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabSelection);
    _tabController?.dispose();
    currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paddingHorizontal = widget.isScrollable ? 16.0 : 0.0;
    return DefaultTabController(
      length: widget.items.length,
      child: ObsBuilder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder(
                valueListenable: currentPage,
                builder: (context, value, child) {
                  return TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: EdgeInsets.symmetric(
                      horizontal: paddingHorizontal,
                      vertical: 1,
                    ),
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    isScrollable: widget.isScrollable,
                    tabAlignment:
                        widget.isScrollable ? TabAlignment.start : null,
                    tabs: [
                      for (int i = 0; i < widget.items.length; i++)
                        Tab(
                          child: Text(
                            widget.items[i].label,
                            style: widget.items[i].labelStyle,
                          ),
                        ),
                    ],
                  );
                },
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: widget.isScrollTabView
                      ? const ScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  children: [
                    for (final item in widget.items)
                      _KeepAliveWrapper(
                        key: item.key,
                        keepAlive: item.keepAlive,
                        child: KeyedSubtree(
                          key: PageStorageKey(item.label),
                          child: item.child,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AppPageViewItems {
  final Key? key;
  final Widget child;
  final String label;
  final TextStyle? labelStyle;
  final bool keepAlive;

  const AppPageViewItems({
    this.key,
    required this.child,
    required this.label,
    this.labelStyle,
    this.keepAlive = true,
  });
}

class _KeepAliveWrapper extends StatefulWidget {
  final bool keepAlive;
  final Widget child;

  const _KeepAliveWrapper({
    super.key,
    required this.keepAlive,
    required this.child,
  });

  @override
  State<_KeepAliveWrapper> createState() => __KeepAliveWrapperState();
}

class __KeepAliveWrapperState extends State<_KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void didUpdateWidget(covariant _KeepAliveWrapper oldWidget) {
    if (oldWidget.keepAlive != widget.keepAlive) {
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }
}
