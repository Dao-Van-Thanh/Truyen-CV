import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:flutter_template/dependency/router/arguments/read_story_argument.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/features/library/widgets/library_bookmarks_option.dart';
import 'package:rxdart/rxdart.dart';

class LibraryBloc extends BlocBase {
  Ref ref;

  late final localApiService = ref.read(AppService.localApi);
  late final routerService = ref.read(AppService.router);

  final listBookmarksSubject = BehaviorSubject<List<BookEntity>>.seeded([]);
  final listHistorySubject = BehaviorSubject<List<BookEntity>>.seeded([]);
  final isLoadingSubject = BehaviorSubject<bool>.seeded(false);

  LibraryBloc(this.ref) {
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    listBookmarksSubject.close();
    listHistorySubject.close();
    isLoadingSubject.close();
  }

  Future<void> _init() async {
    isLoadingSubject.value = true;
    await Future.wait([
      _loadBookmarks(),
      _loadHistory(),
    ]);
    if (isDispose) return;
    isLoadingSubject.value = false;
  }

  void refreshData() {
    _loadBookmarks();
    _loadHistory();
  }

  Future<void> _loadBookmarks() async {
    final bookmarks = await localApiService.bookRepository.getFavoriteBooks();
    if (isDispose) return;
    listBookmarksSubject.add(bookmarks);
  }

  Future<void> _loadHistory() async {
    final now = DateTime.now();
    final history =
        await localApiService.bookRepository.getRecentReadBooks(fromDate: now);
    if (isDispose) return;
    listHistorySubject.add(history);
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
        );
      },
    );
  }

  void _handleRemoveBookmark(BookEntity item) async {
    if (item.isFavorite == false) return;
    await localApiService.bookRepository.upsertBook(
      item.copyWith(isFavorite: false),
    );
    refreshData();
  }

  void _handleAddBookmark(BookEntity item) async {
    if (item.isFavorite == true) return;
    await localApiService.bookRepository.upsertBook(
      item.copyWith(isFavorite: true),
    );
    refreshData();
  }

  void _handleViewInfo(BookEntity item) {
    routerService.push(RouteInput.storyDetail(storyId: item.id));
  }

  void onTapReadStory(BookEntity item) {
    routerService.push(
      RouteInput.readStory(
        args: ReadStoryArgument(
          storyId: item.id,
          selectedChapterId: item.currentChapterId ?? '',
          listChapter: item.listChapters,
          scrollOffset: item.scrollOffset,
        ),
      ),
    );
  }

  void onTapSearch() {
    routerService.push(
      RouteInput.storySearch(),
    );
  }
}
