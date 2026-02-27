import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/router/arguments/explore_category_argument.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/features/explore/widgets/category_page_widget.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:rxdart/rxdart.dart';

class ExploreComicBloc extends BlocBase {
  Ref ref;

  late final networkApiService = ref.read(AppService.networkApi);
  late final routerService = ref.read(AppService.router);

  final isLoadingCategorySubject = BehaviorSubject<bool>.seeded(false);
  final listCategorySubject =
      BehaviorSubject<List<CategoryPageWidgetItem>>.seeded([]);

  ExploreComicBloc(this.ref) {
    _loadCategory();
  }

  @override
  void dispose() {
    super.dispose();
    isLoadingCategorySubject.close();
    listCategorySubject.close();
  }

  Future<void> _loadCategory() async {
    isLoadingCategorySubject.value = true;
    final res = await networkApiService.comicRepository.getListCategory();
    if (isDispose) return;
    isLoadingCategorySubject.value = false;
    res.whenOrNull(
      success: (data) {
        final categories = data.data?.items?.map((e) {
              return CategoryPageWidgetItem(
                id: e.slug ?? '-1',
                categoryName: e.name ?? '',
              );
            }).toList() ??
            [];
        listCategorySubject.value = categories;
      },
      error: (error) {
        logger.e('Error loading categories: $error');
      },
    );
  }

  void onSelectCategory(String id) {
    final category = listCategorySubject.value
        .firstWhereOrNull((element) => element.id == id);
    routerService.push(
      RouteInput.exploreCategory(
        args: ExploreComicCategoryArgument(
          categorySlug: category?.id ?? '',
          title: category?.categoryName ?? '',
        ),
      ),
    );
  }
}
