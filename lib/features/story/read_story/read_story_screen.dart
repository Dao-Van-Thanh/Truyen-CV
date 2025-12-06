import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/features/story/read_story/widgets/read_story_background.dart';
import 'package:flutter_template/features/story/read_story/widgets/read_story_content.dart';
import 'package:flutter_template/features/story/read_story/widgets/read_story_controller.dart';

class ReadStoryScreen extends ConsumerWidget {
  const ReadStoryScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final _ = ref.watch(BlocProvider.readStory);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: ReadStoryBackground(),
          ),
          Positioned.fill(
            child: ReadStoryContent(),
          ),
          Positioned.fill(
            child: ReadStoryController(),
          ),
        ],
      ),
    );
  }
}
