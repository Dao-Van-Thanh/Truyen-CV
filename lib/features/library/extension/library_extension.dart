import 'package:flutter/material.dart';
import 'package:flutter_template/features/library/library_bloc.dart';

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
  }

  void listenScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listenScrollBookmarks();
    });
  }

  void _listenScrollBookmarks() {
    bookmarksScrollController.addListener(() {
      if (bookmarksScrollController.position.pixels >=
          bookmarksScrollController.position.maxScrollExtent - 200) {
        if (isLoadMoreBookmarksSubject.value) return;

        if (isLastPageBookmarks) return;

        bookmarksCurrentPage++;

        _loadBookmarks(page: bookmarksCurrentPage);
      }
    });
  }

  Future<void> onRefreshBookmarks() async {
    bookmarksCurrentPage = 0;
    return _loadBookmarks(page: bookmarksCurrentPage);
  }

  Future<void> _loadBookmarks({int page = 0}) async {
    final bookmarks =
        await localApiService.bookRepository.getFavoriteBooks(page: page);
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
