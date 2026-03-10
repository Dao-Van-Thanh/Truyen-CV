import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/story_entity.dart';
import 'package:flutter_template/dependency/network_api/novel/filter/story_filter_request.dart';
import 'package:flutter_template/dependency/network_api/novel/filter/story_filter_response.dart';
import 'package:flutter_template/dependency/router/arguments/story_detail_argument.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/shared/extensions/infinite_scroll_paination.dart';
import 'package:flutter_template/shared/helper/repository.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:flutter_template/shared/widgets/story_list/enum/story_list_type.dart';
import 'package:flutter_template/shared/widgets/story_list/story_list.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ExploreNovelPageWidget extends ConsumerStatefulWidget {
  final StoryFilterRequest request;
  final StoryListType listType;
  const ExploreNovelPageWidget({
    super.key,
    required this.listType,
    required this.request,
  });

  @override
  ConsumerState<ExploreNovelPageWidget> createState() =>
      _ExploreNovelPageWidgetState();
}

class _ExploreNovelPageWidgetState
    extends ConsumerState<ExploreNovelPageWidget> {
  late final networkApiService = ref.read(AppService.networkApi);

  late final pagingController = PagingController<int, StoryEntity>(
    fetchPage: _loadData,
    getNextPageKey: (state) => state.isLastPage() ? null : state.nextIntPageKey,
  );

  Future<List<StoryEntity>> _loadData(int page) async {
    final res = await networkApiService.novelRepository.getStoryFilter(
      req: StoryFilterRequest(
        cat: widget.request.cat,
        sort: widget.request.sort,
        status: widget.request.status,
        page: page,
      ),
    );

    if (!mounted) return [];

    return res.when<List<StoryEntity>>(
      success: (data) {
        final newStories = data.data ?? [];
        return newStories.map((e) => e.toEntity()).toList();
      },
      error: (error) {
        logger.e('ExploreNovelPageWidget ${error.errorMessage}');
        throw Exception(error);
      },
      handled: () {
        return [];
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    pagingController.dispose();
  }

  void _onTapStory(StoryEntity story) {
    ref.read(AppService.router).push(
          RouteInput.storyDetail(
            args: StoryDetailArgument(
              storyId: story.id,
              fetchStoryDetail: (ref) {
                return RepositoryHelper.fetchStoryNovelDetail(
                  ref,
                  storyId: story.id,
                );
              },
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return StoryList(
      key: PageStorageKey(
        'explore_${widget.request.cat}_${widget.request.sort}',
      ),
      pagingController: pagingController,
      listType: widget.listType,
      onTapItem: (item) {
        _onTapStory(item);
      },
    );
  }
}
