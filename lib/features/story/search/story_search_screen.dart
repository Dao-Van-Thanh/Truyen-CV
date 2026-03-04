import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/features/story/search/widgets/story_search_app_bar.dart';
import 'package:flutter_template/shared/widgets/story_list/enum/story_list_type.dart';
import 'package:flutter_template/shared/widgets/story_list/story_list.dart';

class StorySearchScreen extends ConsumerWidget {
  const StorySearchScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.storySearch);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: StorySearchAppBar(),
      ),
      resizeToAvoidBottomInset: false,
      body: StoryList(
        pagingController: bloc.pagingController,
        listType: StoryListType.list,
        onTapItem: (item) {
          bloc.onTapStory(item);
        },
      ),
    );
  }
}
