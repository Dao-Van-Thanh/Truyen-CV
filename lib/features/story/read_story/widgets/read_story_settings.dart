import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';

class ReadStorySettings extends ConsumerWidget {
  const ReadStorySettings({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.readStory);

    return ObsBuilder(
      streams: [
        bloc.themeModeSubject,
      ],
      builder: (context) {
        final themeMode = bloc.themeModeSubject.value;
        final backgroundColor = themeMode.backgroundColor;
        final textColor = themeMode.textColor;
        return Container(
          height: 200,
          color: backgroundColor,
          child: Center(
            child: Text(
              'Read Story Settings',
              style: TextStyle(color: textColor),
            ),
          ),
        );
      },
    );
  }
}
