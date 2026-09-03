import 'package:flutter/material.dart';
import 'package:truyen_cv/constants/common.dart';
import 'package:truyen_cv/features/library/library_bloc.dart';

extension LibraryExtension on LibraryBloc {
  Future<void> loadData() async {
    _resetData();
    await Future.wait([
      _loadBookmarks(),
      _loadHistory(),
    ]);
  }

  void _resetData() {
    bookmarksCurrentPage = 0;
    historyCurrentPage = 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //scroll to top

      if (bookmarksScrollController.hasClients &&
          bookmarksScrollController.offset > 0) {
        bookmarksScrollController.jumpTo(0);
      }

      if (historyScrollController.hasClients &&
          historyScrollController.offset > 0) {
        historyScrollController.jumpTo(0);
      }
    });
  }

  void listenScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listenScrollBookmarks();
    });
  }

  void _listenScrollBookmarks() {
    bookmarksScrollController.addListener(() async {
      if (!bookmarksScrollController.hasClients) return;
      if (isLoadMoreBookmarksSubject.value || isLastPageBookmarks) return;

      final position = bookmarksScrollController.position;
      if (position.pixels < position.maxScrollExtent - 200) return;

      isLoadMoreBookmarksSubject.value = true;
      bookmarksCurrentPage++;

      try {
        await _loadBookmarks(page: bookmarksCurrentPage);
      } finally {
        if (!isDispose) {
          isLoadMoreBookmarksSubject.value = false;
        }
      }
    });
  }

  Future<void> onRefreshBookmarks() async {
    bookmarksCurrentPage = 0;
    return _loadBookmarks(page: bookmarksCurrentPage);
  }

  Future<void> _loadBookmarks({int page = 0}) async {
    final bookmarks = await localApiService.bookRepository
        .getFavoriteBooks(page: page, limit: CommonConstants.pageSize);
    if (isDispose) return;

    if (page == 0) {
      listBookmarksSubject.add(bookmarks);
      return;
    }

    listBookmarksSubject.value = [...listBookmarksSubject.value, ...bookmarks];
  }

  Future<void> onLoadMoreHistory() async {
    historyCurrentPage++;
    return _loadHistory(page: historyCurrentPage);
  }

  Future<void> onRefreshHistory() async {
    historyCurrentPage = 0;
    return _loadHistory(page: historyCurrentPage);
  }

  Future<void> _loadHistory({int page = 0}) async {
    final history =
        await localApiService.bookRepository.getRecentReadBooks(page: page);
    if (isDispose) return;

    if (page == 0) {
      listHistorySubject.add(history);
      return;
    }

    listHistorySubject.value = [...listHistorySubject.value, ...history];
  }
}
