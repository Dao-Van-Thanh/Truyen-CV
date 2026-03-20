import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truyen_cv/bloc/bloc_provider.dart';
import 'package:truyen_cv/bloc/rx/obs_builder.dart';
import 'package:truyen_cv/features/story/read_comic/widgets/read_comic_content.dart';
import 'package:truyen_cv/features/story/read_comic/widgets/read_comic_controller.dart';
import 'package:truyen_cv/features/story/read_comic/widgets/read_comic_drawer.dart';

class ReadComicScreen extends ConsumerWidget {
  const ReadComicScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
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
