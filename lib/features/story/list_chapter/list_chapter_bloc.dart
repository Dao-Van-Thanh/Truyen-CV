import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/dependency/router/arguments/list_chapter_argument.dart';
import 'package:flutter_template/features/story/list_chapter/enum/list_sort_enum.dart';
import 'package:flutter_template/shared/extensions/text_editing_controller_extension.dart';
import 'package:flutter_template/shared/utilities/debounce.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:rxdart/rxdart.dart';

class ListChapterBloc extends BlocBase {
  Ref ref;
  ListChapterArgument args;

  late final networkApiService = ref.read(AppService.networkApi);

  final isLoadingSubject = BehaviorSubject<bool>.seeded(false);
  final listChapterSubject = BehaviorSubject<List<ListChapterRes>>.seeded([]);
  List<ListChapterRes> listChapterTemp = [];
  final listSortSubject =
      BehaviorSubject<ListSortEnum>.seeded(ListSortEnum.sortOld);

  final scrollController = ScrollController();
  final searchController = TextEditingController();

  final isSearchingSubject = BehaviorSubject<bool>.seeded(false);

  ListChapterBloc(this.ref, {required this.args}) {
    init();
    _listens();
  }

  @override
  void dispose() {
    super.dispose();
    isLoadingSubject.close();
    listChapterSubject.close();
    listSortSubject.close();
    scrollController.dispose();
    isSearchingSubject.close();
    searchController.dispose();
    _removeListens();
  }

  Future<void> init() async {
    isLoadingSubject.value = true;
    final res = await networkApiService.storyRepository.getListChapter(
      args.storyId,
    );
    if (isDispose) return;
    isLoadingSubject.value = false;

    res.whenOrNull(
      success: (data) {
        final listChapter = data.data;
        listChapterSubject.value = listChapter ?? [];
        listChapterTemp = listChapter ?? [];
      },
      error: (error) {
        logger.e('ListChapterBloc init error: $error');
      },
    );
  }

  void onSelectedSort(ListSortEnum p1) {
    listSortSubject.value = p1;
  }

  void onTapSearch() {
    searchController.clear();
    if (isSearchingSubject.value) {
      isSearchingSubject.value = false;
    } else {
      isSearchingSubject.value = true;
    }
  }

  void _listens() {
    searchController.addListenerText(
      (text) {
        final query = text.toLowerCase();
        if (query.isEmpty) {
          listChapterSubject.value = listChapterTemp;
        } else {
          final filteredList = listChapterTemp.where((chapter) {
            final titleLower = chapter.name?.toLowerCase() ?? '';
            return titleLower.contains(query);
          }).toList();
          listChapterSubject.value = filteredList;
        }
      },
      debounce: Debounce(milliseconds: 300),
    );
  }

  void _removeListens() {
    searchController.removeListener(_listens);
  }
}
