import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/features/story/search/widgets/story_search_app_bar.dart';
import 'package:flutter_template/shared/widgets/story_list/entities/story_list_item_entity.dart';
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
      body: ObsBuilder(
        streams: [
          bloc.storiesSubject,
          bloc.isLoadingSubject,
          bloc.isFirstLoadSubject,
          bloc.hasMoreSubject,
        ],
        builder: (context) {
          return StoryList(
            stories: bloc.storiesSubject.value
                .map((e) => StoryListItemEntity.fromStoryModel(e))
                .toList(),
            isLoading: bloc.isLoadingSubject.value,
            isFirstLoad: bloc.isFirstLoadSubject.value,
            hasMore: bloc.hasMoreSubject.value,
            onRefresh: bloc.onRefresh,
            onLoadMore: bloc.loadData,
            listType: StoryListType.list,
          );
        },
      ),
    );
  }
}
