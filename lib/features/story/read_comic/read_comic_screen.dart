import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truyen_cv/bloc/bloc_provider.dart';
import 'package:truyen_cv/bloc/rx/obs_builder.dart';
import 'package:truyen_cv/features/story/read_comic/widgets/read_comic_content.dart';
import 'package:truyen_cv/features/story/read_comic/widgets/read_comic_controller.dart';
import 'package:truyen_cv/features/story/read_comic/widgets/read_comic_drawer.dart';

class ReadComicScreen extends ConsumerStatefulWidget {
  const ReadComicScreen({super.key});

  @override
  ConsumerState<ReadComicScreen> createState() => _ReadComicScreenState();
}

class _ReadComicScreenState extends ConsumerState<ReadComicScreen> {
  StreamSubscription<bool>? _menuSubscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final bloc = ref.read(BlocProvider.readComic);

      _setStatusBarVisible(bloc.isMenuVisibleSubject.value);

      _menuSubscription = bloc.isMenuVisibleSubject.stream.distinct().listen(
        (isVisible) {
          _setStatusBarVisible(isVisible);
        },
      );
    });
  }

  void _setStatusBarVisible(bool isVisible) {
    // Show status bar when menu is visible; hide it for immersive reading.
    // Hide all system overlays when menu is hidden for true fullscreen.
    final overlays = isVisible
        ? <SystemUiOverlay>[SystemUiOverlay.top, SystemUiOverlay.bottom]
        : <SystemUiOverlay>[];

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: overlays,
    );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  void dispose() {
    _menuSubscription?.cancel();
    // Restore default system UI when leaving the reader.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _ = ref.watch(BlocProvider.readComic);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ObsBuilder(
          builder: (context) {
            return Stack(
              children: [
                Positioned.fill(
                  child: ReadComicContent(),
                ),
                Positioned.fill(
                  child: ReadComicController(),
                ),
                Positioned.fill(
                  child: ReadComicDrawer(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
