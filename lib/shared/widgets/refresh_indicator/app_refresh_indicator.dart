import 'package:flutter/material.dart';

class AppRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final ScrollController? controller;
  final bool enableRefresh;

  const AppRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.controller,
    this.enableRefresh = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!enableRefresh) {
      return child;
    }
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        controller: controller,
        slivers: [
          SliverFillRemaining(
            fillOverscroll: true,
            child: RefreshIndicator(
              onRefresh: onRefresh,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
