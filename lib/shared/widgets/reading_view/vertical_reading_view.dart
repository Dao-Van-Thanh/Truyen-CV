import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class VerticalReadingView extends StatefulWidget {
  final PageController pageController;
  final int itemCount;
  final void Function(int)? onPageChanged;
  final Widget Function(
    BuildContext context,
    int index,
    ScrollController scrollController,
  ) itemBuilder;

  const VerticalReadingView({
    super.key,
    this.onPageChanged,
    required this.pageController,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  State<VerticalReadingView> createState() => _VerticalReadingViewState();
}

class _VerticalReadingViewState extends State<VerticalReadingView> {
  late PageController _pageController;
  final Map<int, double> _scrollPositions = {};

  @override
  void initState() {
    super.initState();
    _pageController = widget.pageController;
  }

  @override
  void dispose() {
    if (_pageController.hasClients) {
      _pageController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: widget.onPageChanged,
      physics:
          const NeverScrollableScrollPhysics(parent: ClampingScrollPhysics()),
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        return _VerticalPageWrapper(
          key: ValueKey(index),
          pageController: _pageController,
          initialScrollOffset: _scrollPositions[index] ?? 0.0,
          onScrollChanged: (offset) {
            _scrollPositions[index] = offset;
          },
          builder: (context, scrollController) {
            return widget.itemBuilder(context, index, scrollController);
          },
        );
      },
    );
  }
}

class _VerticalPageWrapper extends StatefulWidget {
  final PageController pageController;
  final Widget Function(BuildContext, ScrollController) builder;
  final double initialScrollOffset;
  final ValueChanged<double>? onScrollChanged;

  const _VerticalPageWrapper({
    super.key,
    required this.pageController,
    required this.builder,
    this.initialScrollOffset = 0.0,
    this.onScrollChanged,
  });

  @override
  State<_VerticalPageWrapper> createState() => _VerticalPageWrapperState();
}

class _VerticalPageWrapperState extends State<_VerticalPageWrapper> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: widget.initialScrollOffset,
    );

    // Lắng nghe scroll để lưu position
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        widget.onScrollChanged?.call(_scrollController.offset);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _PageViewScrollableChild(
      scrollDirection: Axis.vertical,
      pageController: widget.pageController,
      scrollController: _scrollController,
      child: widget.builder(context, _scrollController),
    );
  }
}

class _PageViewScrollableChild extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final PageController pageController;
  final Axis scrollDirection;

  const _PageViewScrollableChild({
    super.key,
    required this.scrollController,
    required this.pageController,
    required this.child,
    required this.scrollDirection,
  });

  @override
  State<StatefulWidget> createState() => _PageViewScrollableChildState();
}

class _PageViewScrollableChildState extends State<_PageViewScrollableChild> {
  ScrollController? activeScrollController;
  Drag? drag;

  @override
  void initState() {
    super.initState();
  }

  void handleDragStart(DragStartDetails details) {
    // Mặc định thử cuộn List trước nếu nó có content
    if (widget.scrollController.hasClients) {
      final pos = widget.scrollController.position;

      // Nếu đang ở đỉnh hoặc đáy tuyệt đối thì cho phép PageView chiếm quyền (để switch page ngay)
      // Nhưng logic update phía dưới sẽ lo phần chuyển đổi mượt hơn, nên ở đây cứ ưu tiên List
      if (pos.minScrollExtent == 0 && pos.maxScrollExtent == 0) {
        // List rỗng -> PageView lo
        activeScrollController = widget.pageController;
      } else {
        activeScrollController = widget.scrollController;
      }
    } else {
      activeScrollController = widget.pageController;
    }

    drag = activeScrollController?.position.drag(details, disposeDrag);
  }

  void handleDragUpdate(DragUpdateDetails details) {
    if (activeScrollController == widget.scrollController &&
        widget.scrollController.hasClients) {
      final double delta = widget.scrollDirection == Axis.vertical
          ? details.delta.dy
          : details.delta.dx;

      final pos = widget.scrollController.position;

      // Logic check offset như bạn yêu cầu:
      // 1. Vuốt lên (delta < 0) VÀ đang ở đáy (pixels >= max) -> Chuyển sang PageView
      // 2. Vuốt xuống (delta > 0) VÀ đang ở đỉnh (pixels <= min) -> Chuyển sang PageView

      if ((delta < 0 && pos.pixels >= pos.maxScrollExtent) ||
          (delta > 0 && pos.pixels <= pos.minScrollExtent)) {
        activeScrollController = widget.pageController;
        drag?.cancel();
        drag = widget.pageController.position.drag(
          DragStartDetails(
            globalPosition: details.globalPosition,
            localPosition: details.localPosition,
          ),
          disposeDrag,
        );
      }
    }

    drag?.update(details);
  }

  void handleDragEnd(DragEndDetails details) {
    drag?.end(details);
  }

  void handleDragCancel() {
    drag?.cancel();
  }

  void disposeDrag() {
    drag = null;
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        VerticalDragGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
          () => VerticalDragGestureRecognizer(),
          (VerticalDragGestureRecognizer instance) {
            instance
              ..onStart = handleDragStart
              ..onUpdate = handleDragUpdate
              ..onEnd = handleDragEnd
              ..onCancel = handleDragCancel;
          },
        ),
      },
      behavior: HitTestBehavior.opaque,
      child: widget.child,
    );
  }
}
