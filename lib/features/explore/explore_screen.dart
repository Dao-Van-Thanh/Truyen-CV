import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore Screen')),
      body: const Center(
        child: Text('Welcome to the Explore Screen'),
      ),
    );
  }
}
