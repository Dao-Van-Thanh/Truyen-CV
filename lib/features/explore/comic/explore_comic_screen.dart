import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreComicScreen extends ConsumerWidget {
  const ExploreComicScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Center(
        child: Text(
          'ExploreComicScreen',
        ),
      ),
    );
  }
}
