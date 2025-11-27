import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndividualScreen extends ConsumerWidget {
  const IndividualScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Individual Screen')),
      body: const Center(
        child: Text('Welcome to the Individual Screen'),
      ),
    );
  }
}
