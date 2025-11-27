import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/constants/colors.dart';

enum LoadingMode {
  icon,
  plain,
}

class LoadingOverlay extends ConsumerStatefulWidget {
  final Widget? child;
  final bool isLoading;
  final Color? barrierColor;
  final Color? loadingColor;
  final LoadingMode mode;

  const LoadingOverlay({
    super.key,
    this.child,
    required this.isLoading,
    this.barrierColor,
    this.loadingColor,
    this.mode = LoadingMode.icon,
  });

  @override
  ConsumerState<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends ConsumerState<LoadingOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final barrierColor =
        ref.read(BlocProvider.config).currentThemeMode == ThemeMode.dark
            ? ColorConstants.backgroundDark
            : ColorConstants.backgroundLight;
    return SizedBox.expand(
      child: Stack(
        children: [
          widget.child ?? const SizedBox.shrink(),
          if (widget.isLoading)
            Stack(
              children: [
                ModalBarrier(
                  dismissible: false,
                  color: widget.barrierColor ?? barrierColor,
                ),
                if (widget.mode == LoadingMode.icon)
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: RotationTransition(
                        turns: _controller,
                        child: Icon(
                          Icons.autorenew,
                          size: 40,
                          color: widget.loadingColor ?? Colors.deepPurple,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
