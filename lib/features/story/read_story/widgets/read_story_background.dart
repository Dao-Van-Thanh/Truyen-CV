import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truyen_cv/bloc/bloc_provider.dart';
import 'package:truyen_cv/bloc/rx/obs_builder.dart';

class ReadStoryBackground extends ConsumerWidget {
  const ReadStoryBackground({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.readStory);
    return ObsBuilder(
      streams: [bloc.configStorySubject],
      builder: (context) {
        final config = bloc.configStorySubject.value;
        return Container(
          decoration: BoxDecoration(
            color: config.themeMode.backgroundColor,
          ),
        );
      },
    );
  }
}
