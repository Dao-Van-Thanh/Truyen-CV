import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/network_api/story/detail/story_detail_response.dart';
import 'package:flutter_template/dependency/router/arguments/list_chapter_argument.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:rxdart/rxdart.dart';

class StoryDetailBloc extends BlocBase {
  Ref ref;
  String storyId;

  late final networkApiService = ref.read(AppService.networkApi);
  late final routerService = ref.read(AppService.router);

  final isLoadingSubject = BehaviorSubject<bool>.seeded(false);

  final storyDetailSubject = BehaviorSubject<StoryDetailResponse?>.seeded(null);

  final scrollController = ScrollController();

  final scrollBehaviorSubject =
      BehaviorSubject<double>.seeded(0.0); // 0.0 - 1.0

  StoryDetailBloc(this.ref, {required this.storyId}) {
    loadStoryDetail();
    _listeners();
  }

  @override
  void dispose() {
    super.dispose();
    isLoadingSubject.close();
    storyDetailSubject.close();
    scrollController.dispose();
    scrollBehaviorSubject.close();
    _removeListeners();
  }

  void _listeners() {
    scrollController.addListener(() {
      final maxScroll = 100;
      final currentScroll = scrollController.position.pixels;
      final scrollPercent = (currentScroll / maxScroll).clamp(0.0, 1.0);
      scrollBehaviorSubject.add(scrollPercent);
    });
  }

  void _removeListeners() {
    scrollController.removeListener(() {});
  }

  Future<void> loadStoryDetail() async {
    isLoadingSubject.value = true;
    final res = await networkApiService.storyRepository.storyDetail(storyId);
    if (isDispose) return;
    isLoadingSubject.value = false;

    res.whenOrNull(
      success: (data) {
        storyDetailSubject.value = data.data;
      },
      error: (error) {
        logger
            .e('StoryDetailBloc _loadStoryDetail error: ${error.errorMessage}');
      },
    );
  }

  void onTapCopyStoryName() {
    final storyName = storyDetailSubject.value?.name ?? '';
    final context = routerService.rootContext;
    Clipboard.setData(ClipboardData(text: storyName));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.storyDetail.copyStoryNameSuccess(name: storyName)),
      ),
    );
  }

  void onTapNextListChapter() {
    final args = ListChapterArgument(
      storyId: storyId,
      storyName: storyDetailSubject.value?.name ?? '',
    );
    routerService.push(RouteInput.listChapter(args: args));
  }
}
