import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/shared/utilities/logger.dart';

class ExploreBloc extends BlocBase {
  Ref ref;

  late final networkApiService = ref.read(AppService.networkApi);

  ExploreBloc(this.ref) {
    _getListCategory();
  }

  Future<void> _getListCategory() async {
    final res = await networkApiService.storyRepository.getListCategory();
    res.whenOrNull(
      success: (data) {
        logger.i('Get list category success: ${data.data} categories');
      },
    );
  }
}
