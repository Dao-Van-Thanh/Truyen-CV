import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:rxdart/rxdart.dart';

class LibraryBloc extends BlocBase {
  Ref ref;

  late final localApiService = ref.read(AppService.localApi);

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
}
