import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/network_api/story/category/category_model.dart';
import 'package:rxdart/rxdart.dart';

class ExploreBloc extends BlocBase {
  Ref ref;

  late final networkApiService = ref.read(AppService.networkApi);

  final categoriesSubject = BehaviorSubject<List<CategoryModel>>.seeded([]);

  final isLoadingSubject = BehaviorSubject<bool>.seeded(false);

  ExploreBloc(this.ref) {
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
    final res = await networkApiService.storyRepository.getListCategory();
    isLoadingSubject.value = false;
    res.whenOrNull(
      success: (data) {
        categoriesSubject.add(data.data ?? []);
      },
    );
  }
}
