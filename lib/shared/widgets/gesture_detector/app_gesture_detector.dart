import 'package:flutter/material.dart';

class AppGestureDetector extends GestureDetector {
  AppGestureDetector({
    super.key,
    required Widget child,
    bool isDisable = false,
    VoidCallback? onTap,
    super.behavior,
  }) : super(
          onTap: () {
            if (isDisable) return;
            onTap?.call();
          },
          child: Container(
            color: Colors.transparent,
            child: child,
          ),
        );
}
