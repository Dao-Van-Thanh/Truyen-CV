import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/story_entity.dart';
import 'package:flutter_template/dependency/network_api/comic/list_comic/list_comic_res.dart';
import 'package:flutter_template/dependency/router/arguments/story_detail_argument.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/shared/extensions/infinite_scroll_paination.dart';
import 'package:flutter_template/shared/helper/repository.dart';
import 'package:flutter_template/shared/widgets/story_list/enum/story_list_type.dart';
import 'package:flutter_template/shared/widgets/story_list/story_list.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ExploreComicPageWidget extends ConsumerStatefulWidget {
  final String categorySlug;
  final StoryListType listType;
  const ExploreComicPageWidget({
    super.key,
    required this.listType,
    required this.categorySlug,
  });

  @override
  ConsumerState<ExploreComicPageWidget> createState() =>
      _ExploreComicPageWidgetState();
}

class _ExploreComicPageWidgetState
    extends ConsumerState<ExploreComicPageWidget> {
  late final networkApiService = ref.read(AppService.networkApi);

  late final _pagingController = PagingController<int, StoryEntity>(
    getNextPageKey: (state) => state.isLastPage() ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => _loadData(pageKey),
  );

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  Future<List<StoryEntity>> _loadData(int page) async {
    try {
      final res = await networkApiService.comicRepository.getListByType(
        widget.categorySlug,
        page: page,
      );

      if (!mounted) return [];

      return res.when<List<StoryEntity>>(
        success: (data) {
          final newStories = data.data?.toStoryEntity() ?? [];
          return newStories;
        },
        error: (error) {
          throw Exception(error.errorMessage);
        },
        handled: () {
          return [];
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  void _onTapItem(StoryEntity item) {
    ref.read(AppService.router).push(
          RouteInput.storyDetail(
            args: StoryDetailArgument(
              storyId: item.id,
              fetchStoryDetail: (ref) {
                return RepositoryHelper.fetchStoryComicDetail(
                  ref,
                  storyId: item.id,
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
        'explore_${widget.categorySlug}_${widget.listType}',
      ),
      pagingController: _pagingController,
      listType: widget.listType,
      onTapItem: _onTapItem,
    );
  }
}
