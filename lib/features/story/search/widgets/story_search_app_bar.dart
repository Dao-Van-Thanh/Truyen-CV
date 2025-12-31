import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/i18n/strings.g.dart';

class StorySearchAppBar extends ConsumerWidget {
  const StorySearchAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.storySearch);
    final t = context.t;
    return ObsBuilder(
      streams: [],
      builder: (context) {
        return AppBar(
          title: TextField(
            key: key,
            focusNode: bloc.searchFocusNode,
            autofocus: false,
            controller: bloc.searchController,
            decoration: InputDecoration(
              hintText: t.common.searchTitle,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: const TextStyle(fontSize: 18),
          ),
          leading: const BackButton(),
          centerTitle: false,
          actions: [
            IconButton(
              key: const ValueKey('closeBtn'),
              icon: const Icon(Icons.clear),
              onPressed: bloc.onTapClearSearch,
            ),
          ],
        );
      },
    );
  }
}
