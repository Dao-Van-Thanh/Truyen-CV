import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';

class ReadStoryBackground extends ConsumerWidget {
  const ReadStoryBackground({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.readStory);
    return ObsBuilder(
      streams: [bloc.themeModeSubject],
      builder: (context) {
        final themeMode = bloc.themeModeSubject.value;
        return Container(
          decoration: BoxDecoration(
            color: themeMode.backgroundColor,
          ),
        );
      },
    );
  }
}
