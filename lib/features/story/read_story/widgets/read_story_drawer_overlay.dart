import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/features/story/read_story/widgets/read_story_drawer.dart';

class ReadStoryDrawerOverlay extends ConsumerStatefulWidget {
  const ReadStoryDrawerOverlay({
    super.key,
  });

  @override
  ConsumerState<ReadStoryDrawerOverlay> createState() =>
      _ReadStoryDrawerOverlayState();
}

class _ReadStoryDrawerOverlayState extends ConsumerState<ReadStoryDrawerOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final bloc = ref.watch(BlocProvider.readStory);
  StreamSubscription<bool>? _subscriptionStream;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    _subscriptionStream = bloc.isOpenDrawerSubject.listen((isOpen) {
      if (isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _subscriptionStream?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.9;

    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            final isVisible = _controller.value > 0;

            return isVisible
                ? Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: bloc.onTapToggleDrawer,
                      child: Container(
                        color: Colors.black.withValues(
                          alpha: 0.4 * _controller.value,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),

        /// Drawer
        AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return Positioned(
              left: -width + width * _controller.value,
              top: 0,
              bottom: 0,
              width: width,
              child: ReadStoryDrawer(),
            );
          },
        ),
      ],
    );
  }
}
