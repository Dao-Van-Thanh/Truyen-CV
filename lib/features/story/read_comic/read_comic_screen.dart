import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/features/story/read_comic/widgets/read_comic_content.dart';
import 'package:flutter_template/features/story/read_comic/widgets/read_comic_controller.dart';
import 'package:flutter_template/features/story/read_comic/widgets/read_comic_drawer.dart';

class ReadComicScreen extends ConsumerWidget {
  const ReadComicScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final _ = ref.watch(BlocProvider.readComic);
    return Scaffold(
      backgroundColor: Colors.black,
      body: ObsBuilder(
        // streams: [bloc.isLoadingSubject],
        builder: (context) {
          return Stack(
            children: [
              Positioned.fill(
                child: ReadComicContent(),
              ),
              Positioned.fill(
                child: ReadComicController(),
              ),
              // if (bloc.isLoadingSubject.value)
              //   Center(
              //     child: CircularProgressIndicator(
              //       color: Theme.of(context).colorScheme.primary,
              //     ),
              //   ),

              Positioned.fill(
                child: ReadComicDrawer(),
              ),
            ],
          );
        },
      ),
    );
  }
}
