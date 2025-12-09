import 'package:flutter/material.dart';

class AppGestureDetector extends GestureDetector {
  AppGestureDetector({
    super.key,
    required Widget child,
    bool isDisable = false,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    super.behavior,
  }) : super(
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
