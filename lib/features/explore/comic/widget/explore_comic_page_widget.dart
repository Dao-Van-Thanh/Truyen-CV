import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/story_entity.dart';
import 'package:flutter_template/dependency/network_api/comic/list_comic/list_comic_res.dart';
import 'package:flutter_template/dependency/router/arguments/story_detail_argument.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/shared/helper/repository.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:flutter_template/shared/widgets/story_list/enum/story_list_type.dart';
import 'package:flutter_template/shared/widgets/story_list/story_list.dart';

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

  final List<StoryEntity> _stories = [];
  bool _isLoading = false;
  bool _isFirstLoad = true;
  bool _hasMore = true;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final res = await networkApiService.comicRepository.getListByType(
        widget.categorySlug,
        page: _currentPage,
      );

      if (!mounted) return;

      res.whenOrNull(
        success: (data) {
          final newStories = data.data?.toStoryEntity() ?? [];

          setState(() {
            if (newStories.isEmpty) {
              _hasMore = false;
            } else {
              _stories.addAll(newStories);
              _currentPage++;
            }
            _isLoading = false;
            _isFirstLoad = false;
          });
        },
        error: (error) {
          setState(() {
            _isLoading = false;
            _isFirstLoad = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.errorMessage}')),
          );
        },
      );
    } catch (e) {
      logger.e('Error loading comics: $e');
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _isFirstLoad = false;
      });
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      _stories.clear();
      _currentPage = 1;
      _hasMore = true;
      _isFirstLoad = true;
    });
    await _loadData();
  }

  void _onTapItem(StoryEntity item) {
    final slug = item.id.split('||').lastOrNull ?? '';
    ref.read(AppService.router).push(
          RouteInput.storyDetail(
            args: StoryDetailArgument(
              storyId: item.id,
              fetchStoryDetail: (ref) {
                return RepositoryHelper.fetchStoryComicDetail(
                  ref,
                  storySlug: slug,
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
      stories: _stories,
      isLoading: _isLoading,
      isFirstLoad: _isFirstLoad,
      hasMore: _hasMore,
      onRefresh: _onRefresh,
      onLoadMore: _loadData,
      listType: widget.listType,
      onTapItem: _onTapItem,
    );
  }
}
