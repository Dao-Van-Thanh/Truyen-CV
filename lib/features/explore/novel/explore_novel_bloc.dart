import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:truyen_cv/bloc/bloc_base.dart';
import 'package:truyen_cv/bloc/bloc_provider.dart';
import 'package:truyen_cv/dependency/app_service.dart';
import 'package:truyen_cv/dependency/local_api/repository/book/entities/story_entity.dart';
import 'package:truyen_cv/dependency/network_api/novel/category/category_model.dart';
import 'package:truyen_cv/dependency/network_api/novel/detail/story_detail_response.dart';
import 'package:truyen_cv/dependency/network_api/novel/filter/story_filter_request.dart';
import 'package:truyen_cv/dependency/router/arguments/explore_category_argument.dart';
import 'package:truyen_cv/dependency/router/arguments/story_detail_argument.dart';
import 'package:truyen_cv/dependency/router/utils/route_input.dart';
import 'package:truyen_cv/features/story/detail/entities/story_detail_entity.dart';
import 'package:truyen_cv/shared/helper/repository.dart';

class ExploreNovelBloc extends BlocBase {
  Ref ref;
  late final networkApiService = ref.read(AppService.networkApi);
  late final routerService = ref.read(AppService.router);
  late final appConfigBloc = ref.read(BlocProvider.config);

  final categoriesSubject = BehaviorSubject<List<CategoryModel>>.seeded([]);
  final isLoadingSubject = BehaviorSubject<bool>.seeded(false);

  ExploreNovelBloc(this.ref) {
    _getListCategory();
  }

  @override
  void dispose() {
    super.dispose();
    categoriesSubject.close();
    isLoadingSubject.close();
  }

  Future<void> _getListCategory() async {
    isLoadingSubject.value = true;
    final res = await networkApiService.novelRepository.getListCategory();
    if (isDispose) return;
    isLoadingSubject.value = false;
    res.whenOrNull(
      success: (data) {
        categoriesSubject.add(data.data ?? []);
      },
    );
  }

  void onSelectCategory(String id) {
    final category =
        categoriesSubject.value.firstWhereOrNull((element) => element.id == id);
    routerService.push(
      RouteInput.exploreCategory(
        args: ExploreNovelCategoryArgument(
          request: StoryFilterRequest(
            cat: int.parse('${category?.id ?? 0}'),
          ),
          title: category?.name ?? '',
        ),
      ),
    );
  }

  void onTapStory(StoryEntity story) {
    routerService.push(
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

  Future<StoryDetailEntity?> _fetchStoryDetail(String storyId) async {
    final res = await networkApiService.novelRepository.storyDetail(storyId);
    return res.whenOrNull<StoryDetailEntity?>(
      success: (data) => data.data?.toEntity(),
      error: (error) => null,
    );
  }
}
