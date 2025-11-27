import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/network_api/story/filter/story_filter_request.dart';
import 'package:flutter_template/dependency/network_api/story/filter/story_filter_response.dart';
import 'package:flutter_template/features/explore/enum/explore_enum.dart';
import 'package:flutter_template/features/explore/widgets/story_grid_list.dart';

class ExplorePageWidget extends ConsumerStatefulWidget {
  final ExploreEnum exploreEnum;
  const ExplorePageWidget({super.key, required this.exploreEnum});

  @override
  ConsumerState<ExplorePageWidget> createState() => _ExplorePageWidgetState();
}

class _ExplorePageWidgetState extends ConsumerState<ExplorePageWidget> {
  late final networkApiService = ref.read(AppService.networkApi);

  final List<StoryModel> _stories = [];
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
      final res = await networkApiService.storyRepository.getStoryFilter(
        req: StoryFilterRequest(
          sort: widget.exploreEnum.page,
          page: _currentPage,
        ),
      );

      if (!mounted) return;

      res.whenOrNull(
        success: (data) {
          final newStories = data.data ?? [];
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

  @override
  Widget build(BuildContext context) {
    return StoryGridList(
      stories: _stories,
      isLoading: _isLoading,
      isFirstLoad: _isFirstLoad,
      hasMore: _hasMore,
      onRefresh: _onRefresh,
      onLoadMore: _loadData,
    );
  }
}
