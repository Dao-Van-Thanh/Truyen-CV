import 'package:flutter/material.dart';
import 'package:flutter_template/constants/constants.dart';

class AppContentHeightDetector extends StatefulWidget {
  final ScrollController scrollController;
  final Widget Function(BuildContext context)? buildFooter;
  final Widget Function(
    BuildContext context,
    Widget Function(bool isLoading) buildEndOfList,
    bool isTaller,
  ) builder;

  const AppContentHeightDetector({
    super.key,
    required this.buildFooter,
    required this.scrollController,
    required this.builder,
  });

  @override
  State<AppContentHeightDetector> createState() =>
      _AppContentHeightDetectorState();
}

class _AppContentHeightDetectorState extends State<AppContentHeightDetector> {
  bool _isTaller = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkHeight());
  }

  @override
  void didUpdateWidget(covariant AppContentHeightDetector oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkHeight());
  }

  void _checkHeight() {
    if (!widget.scrollController.hasClients || !mounted) return;

    final screenHeight = MediaQuery.of(context).size.height;
    final scrollViewHeight = widget.scrollController.position.viewportDimension;
    final contentHeight =
        widget.scrollController.position.maxScrollExtent + scrollViewHeight;

    final isTaller = contentHeight > screenHeight;

    if (_isTaller != isTaller) {
      setState(() {
        _isTaller = isTaller;
      });
    }
  }

  Widget _buildEndOfList(bool isLoading) {
    if (isLoading) return SizedBoxConstants.shrink;

    if (!_isTaller) return SizedBoxConstants.shrink;

    if (widget.buildFooter == null) return SizedBoxConstants.shrink;

    return SafeArea(
      child: Center(
        child: Column(
          children: [
            SizedBoxConstants.s8,
            widget.buildFooter!.call(context),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _buildEndOfList, _isTaller);
  }
}
