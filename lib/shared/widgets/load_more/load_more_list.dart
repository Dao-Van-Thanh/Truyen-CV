import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadMoreList extends StatelessWidget {
  const LoadMoreList({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(child: _loader(context));
  }

  Widget _loader(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SizedBox(
          width: 20,
          height: 20,
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
      ),
    );
  }
}
