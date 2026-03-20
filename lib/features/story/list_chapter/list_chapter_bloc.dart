import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:truyen_cv/bloc/bloc_base.dart';
import 'package:truyen_cv/dependency/app_service.dart';
import 'package:truyen_cv/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:truyen_cv/dependency/local_api/repository/book/entities/list_chapter_entity.dart';
import 'package:truyen_cv/dependency/router/arguments/list_chapter_argument.dart';
import 'package:truyen_cv/dependency/router/arguments/read_story_argument.dart';
import 'package:truyen_cv/features/story/list_chapter/enum/list_sort_enum.dart';
import 'package:truyen_cv/shared/extensions/router.dart';
import 'package:truyen_cv/shared/extensions/text_editing_controller_extension.dart';
import 'package:truyen_cv/shared/utilities/debounce.dart';
import 'package:truyen_cv/shared/utilities/logger.dart';

class ListChapterBloc extends BlocBase {
  Ref ref;
  ListChapterArgument args;

  late final routerService = ref.read(AppService.router);
  late final localApiService = ref.read(AppService.localApi);

  final listChapterSubject =
      BehaviorSubject<List<ListChapterEntity>>.seeded([]);
  List<ListChapterEntity> listChapterTemp = [];
  final listSortSubject =
      BehaviorSubject<ListSortEnum>.seeded(ListSortEnum.sortOld);

  final scrollController = ScrollController();
  final searchController = TextEditingController();

  final isSearchingSubject = BehaviorSubject<bool>.seeded(false);
  final isContinueReadingSubject = BehaviorSubject<bool>.seeded(false);

  bool _isLoadingLocal = false;

  ListChapterBloc(this.ref, {required this.args}) {
    final listChapter = args.storyData.listChapter;
    listChapterSubject.value = listChapter;
    listChapterTemp = listChapter;
    _getBookLocal();
    _listens();
  }

  @override
  void dispose() {
    super.dispose();
    listChapterSubject.close();
    listSortSubject.close();
    scrollController.dispose();
    isSearchingSubject.close();
    searchController.dispose();
    isContinueReadingSubject.close();
    _removeListens();
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
            final titleLower = chapter.name.toLowerCase();
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

  void onTapChapter(ListChapterEntity chapter) {
    _upsertBookToLocal(
      chapter.id,
      0.0,
    ).then(
      (_) {
        routerService
            .pushReadStory(
          args.storyData.type,
          args: ReadStoryArgument(
            storyId: args.storyData.id,
            selectedChapterId: chapter.id,
            listChapter: listChapterSubject.value,
            scrollOffset: 0.0,
          ),
        )
            .then((_) {
          _getBookLocal();
        });
      },
    );
  }

  Future<void> _getBookLocal() async {
    final bookEntityLocal = await localApiService.bookRepository.getBookById(
      args.storyData.id,
    );
    if (isDispose) return;
    if (bookEntityLocal != null && bookEntityLocal.currentChapterId != null) {
      isContinueReadingSubject.value = true;
    } else {
      isContinueReadingSubject.value = false;
    }
  }

  Future<void> _upsertBookToLocal(
    String selectedChapterId,
    double scrollOffset,
  ) async {
    if (_isLoadingLocal) return;

    try {
      final listChapter = listChapterSubject.value;
      final bookEntity = BookEntity(
        id: args.storyData.id,
        listChapters: listChapter,
        storyData: args.storyData,
        currentChapterId: selectedChapterId,
        scrollOffset: scrollOffset,
        lastReadTime: DateTime.now().toIso8601String(),
        timeStamp: DateTime.now().toIso8601String(),
        isLocal: false,
      );
      _isLoadingLocal = true;
      await localApiService.bookRepository.upsertBook(
        bookEntity,
        isHasUpdateListChapter: true,
      );
      _isLoadingLocal = false;
    } catch (e) {
      logger.e('Error saving book to local: $e');
    }
  }

  void onTapContinueReading() async {
    final bookEntityLocal = await localApiService.bookRepository.getBookById(
      args.storyData.id,
    );
    if (isDispose) return;
    if (bookEntityLocal == null) return;
    routerService.pushReadStory(
      args.storyData.type,
      args: ReadStoryArgument(
        storyId: args.storyData.id,
        selectedChapterId: bookEntityLocal.currentChapterId ?? '-1',
        listChapter: bookEntityLocal.listChapters,
        scrollOffset: bookEntityLocal.scrollOffset,
      ),
    );
  }
}
