import 'package:flutter/material.dart';

class AppRawScrollBar extends StatelessWidget {
  final ScrollController controller;
  final Widget child;

  const AppRawScrollBar({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      controller: controller,
      thumbVisibility: false,
      interactive: true,
      thickness: 12,
      shape: const StadiumBorder(),
      thumbColor: Theme.of(context).colorScheme.primary,
      fadeDuration: const Duration(milliseconds: 500),
      timeToFade: const Duration(milliseconds: 800),
      child: child,
    );
  }
}
