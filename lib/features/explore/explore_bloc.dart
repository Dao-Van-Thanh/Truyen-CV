import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/network_api/story/category/category_model.dart';
import 'package:flutter_template/dependency/network_api/story/filter/story_filter_request.dart';
import 'package:flutter_template/dependency/router/arguments/explore_argument.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/shared/widgets/story_list/enum/story_list_type.dart';
import 'package:rxdart/rxdart.dart';

class ExploreBloc extends BlocBase {
  Ref ref;
  ExploreArgument? args;

  late final networkApiService = ref.read(AppService.networkApi);
  late final routerService = ref.read(AppService.router);

  final categoriesSubject = BehaviorSubject<List<CategoryModel>>.seeded([]);

  final isLoadingSubject = BehaviorSubject<bool>.seeded(false);

  final listTypeSubject =
      BehaviorSubject<StoryListType>.seeded(StoryListType.grid);

  ExploreBloc(this.ref, {this.args}) {
    _getListCategory();
  }

  @override
  void dispose() {
    super.dispose();
    categoriesSubject.close();
    isLoadingSubject.close();
    listTypeSubject.close();
  }

  Future<void> _getListCategory() async {
    if (args != null) return;
    isLoadingSubject.value = true;
    final res = await networkApiService.storyRepository.getListCategory();
    if (isDispose) return;
    isLoadingSubject.value = false;
    res.whenOrNull(
      success: (data) {
        categoriesSubject.add(data.data ?? []);
      },
    );
  }

  void onChangeListType(StoryListType type) {
    if (type == listTypeSubject.value) return;
    listTypeSubject.add(type);
  }

  void onSelectCategory(CategoryModel category) {
    routerService.push(
      RouteInput.explore(
        arguments: ExploreArgument(
          request: StoryFilterRequest(
            cat: int.parse('${category.id ?? 0}'),
          ),
          title: category.name,
        ),
      ),
    );
  }
}
