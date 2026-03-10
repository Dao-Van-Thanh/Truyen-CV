import 'package:flutter/material.dart';

class AppTapAndScrollDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onScroll;
  final HitTestBehavior behavior;

  const AppTapAndScrollDetector({
    super.key,
    required this.child,
    this.onTap,
    this.onScroll,
    this.behavior = HitTestBehavior.translucent,
  });

  @override
  State<AppTapAndScrollDetector> createState() =>
      _AppTapAndScrollDetectorState();
}

class _AppTapAndScrollDetectorState extends State<AppTapAndScrollDetector> {
  bool _isDragging = false;
  late DateTime _pointerDownTime;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: widget.behavior,
      onPointerDown: (_) {
        _pointerDownTime = DateTime.now();
        _isDragging = false;
      },
      onPointerMove: (_) {
        if (!_isDragging) {
          _isDragging = true;
          widget.onScroll?.call();
        }
      },
      onPointerUp: (_) {
        final duration = DateTime.now().difference(_pointerDownTime);

        if (!_isDragging && duration < const Duration(milliseconds: 300)) {
          widget.onTap?.call();
        }
      },
      child: widget.child,
    );
  }
}
