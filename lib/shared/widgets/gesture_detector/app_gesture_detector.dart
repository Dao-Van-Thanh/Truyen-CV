import 'package:flutter/material.dart';

class AppGestureDetector extends GestureDetector {
  AppGestureDetector({
    super.key,
    required Widget child,
    bool isDisable = false,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    HitTestBehavior? behavior,
  }) : super(
          behavior: isDisable ? HitTestBehavior.translucent : behavior,
          onTap: () {
            if (isDisable) return;
            onTap?.call();
          },
          onLongPress: () {
            if (isDisable) return;
            onLongPress?.call();
          },
          child: Container(
            color: Colors.transparent,
            child: child,
          ),
        );
}
