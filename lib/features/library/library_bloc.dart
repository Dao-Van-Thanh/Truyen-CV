import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:flutter_template/dependency/local_api/repository/book/enum/story_type.dart';
import 'package:flutter_template/dependency/router/arguments/read_story_argument.dart';
import 'package:flutter_template/dependency/router/arguments/story_detail_argument.dart';
import 'package:flutter_template/dependency/router/arguments/story_search_argument.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/features/library/extension/library_extension.dart';
import 'package:flutter_template/features/library/widgets/library_bookmarks_option.dart';
import 'package:flutter_template/shared/extensions/router.dart';
import 'package:flutter_template/shared/helper/repository.dart';
import 'package:flutter_template/shared/widgets/dialog/file_import_dialog.dart';
import 'package:rxdart/rxdart.dart';

class LibraryBloc extends BlocBase {
  Ref ref;

  late final localApiService = ref.read(AppService.localApi);
  late final routerService = ref.read(AppService.router);

  final listBookmarksSubject = BehaviorSubject<List<BookEntity>>.seeded([]);
  final listHistorySubject = BehaviorSubject<List<BookEntity>>.seeded([]);
  final isLoadingSubject = BehaviorSubject<bool>.seeded(false);

  final bookmarksScrollController = ScrollController();
  final historyScrollController = ScrollController();

  final isLoadMoreBookmarksSubject = BehaviorSubject<bool>.seeded(false);

  int bookmarksCurrentPage = 0;
  int historyCurrentPage = 0;

  bool get isLastPageBookmarks =>
      listBookmarksSubject.value.length < (bookmarksCurrentPage + 1) * 20;

  LibraryBloc(this.ref) {
    _init();
    listenScroll();
  }

  @override
  void dispose() {
    super.dispose();
    listBookmarksSubject.close();
    listHistorySubject.close();
    isLoadingSubject.close();
    bookmarksScrollController.dispose();
    isLoadMoreBookmarksSubject.close();
    historyScrollController.dispose();
  }

  Future<void> _init() async {
    isLoadingSubject.value = true;
    await loadData();
    if (isDispose) return;
    isLoadingSubject.value = false;
  }

  void onTapLongPressStory(BookEntity item) async {
    showModalBottomSheet(
      context: routerService.rootContext,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return LibraryBookmarksOption(
          item,
          onTapAddOrRemoveBookmark: (isRemove) {
            if (isRemove) {
              _handleRemoveBookmark(item);
            } else {
              _handleAddBookmark(item);
            }
          },
          onTapViewInfo: () {
            _handleViewInfo(item);
          },
          onTapDeleteLocalStory: () {
            _handleRemoveStory(item);
          },
        );
      },
    );
  }

  void _handleRemoveBookmark(BookEntity item) async {
    if (item.isFavorite == false) return;
    await localApiService.bookRepository.upsertBook(
      item.copyWith(isFavorite: false),
      isHasUpdateListChapter: false,
    );
    loadData();
  }

  void _handleAddBookmark(BookEntity item) async {
    if (item.isFavorite == true) return;
    await localApiService.bookRepository.upsertBook(
      item.copyWith(isFavorite: true),
      isHasUpdateListChapter: false,
    );
    loadData();
  }

  void _handleViewInfo(BookEntity item) {
    final isNovel = item.storyData.type.isNovel;

    if (isNovel) {
      routerService.push(
        RouteInput.storyDetail(
          args: StoryDetailArgument(
            storyId: item.id,
            fetchStoryDetail: (ref) {
              return RepositoryHelper.fetchStoryNovelDetail(
                ref,
                storyId: item.id,
              );
            },
          ),
        ),
      );
    } else {
      routerService.push(
        RouteInput.storyDetail(
          args: StoryDetailArgument(
            storyId: item.id,
            fetchStoryDetail: (ref) {
              return RepositoryHelper.fetchStoryComicDetail(
                ref,
                storyId: item.id,
              );
            },
          ),
        ),
      );
    }
  }

  void onTapReadStory(BookEntity item) {
    routerService.pushReadStory(
      item.storyData.type,
      args: ReadStoryArgument(
        storyId: item.id,
        selectedChapterId: item.currentChapterId ?? '',
        listChapter: item.listChapters,
        scrollOffset: item.scrollOffset,
        isOfflineImport: item.isLocal,
      ),
    );
  }

  void onTapSearch() {
    routerService.push(
      RouteInput.storySearch(
        args: StorySearchArgument(
          fetchSearchStory: (ref, keyword, page) {
            return RepositoryHelper.fetchStoryNovelSearch(
              ref,
              keyword: keyword,
              page: page,
            );
          },
          fetchStoryDetail: (ref, storyId) {
            return RepositoryHelper.fetchStoryNovelDetail(
              ref,
              storyId: storyId,
            );
          },
        ),
      ),
    );
  }

  void onTapAddStory() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['epub', 'txt'],
    );

    if (result?.files.isEmpty ?? true) return;

    final filePath = result!.files.first.path;
    if (filePath == null || filePath.isEmpty) return;

    if (!routerService.rootContext.mounted) return;

    showDialog(
      context: routerService.rootContext,
      builder: (context) {
        return FileImportDialog(filePath: filePath);
      },
    );
  }

  void _handleRemoveStory(BookEntity item) {
    localApiService.bookRepository.deleteBook(item.id);
    loadData();
  }
}
