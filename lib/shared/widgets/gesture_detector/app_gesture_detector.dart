import 'package:flutter/material.dart';

class AppGestureDetector extends StatelessWidget {
  final Widget child;
  final bool isDisable;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final HitTestBehavior? behavior;

  const AppGestureDetector({
    super.key,
    required this.child,
    this.isDisable = false,
    this.onTap,
    this.onLongPress,
    this.behavior,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isDisable,
      child: GestureDetector(
        behavior: behavior,
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          color: Colors.transparent,
          child: child,
        ),
      ),
    );
  }
}
