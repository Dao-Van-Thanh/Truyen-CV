import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/list_chapter_entity.dart';
import 'package:flutter_template/dependency/network_api/comic/contents/comic_contents_res.dart';
import 'package:flutter_template/dependency/router/arguments/read_comic_argument.dart';
import 'package:flutter_template/features/story/read_comic/entities/comic_chapter_entity.dart';
import 'package:flutter_template/shared/utilities/debounce.dart';
import 'package:flutter_template/shared/utilities/logger.dart';
import 'package:rxdart/rxdart.dart';

class ReadComicBloc extends BlocBase {
  Ref ref;

  late ReadComicArgument _args;

  String get storyId => _args.storyId;
  String get selectedChapterId => _args.selectedChapterId;
  double get scrollOffset => _args.scrollOffset;

  late final networkApiService = ref.read(AppService.networkApi);
  late final localApiService = ref.read(AppService.localApi);

  final comicChaptersSubject =
      BehaviorSubject<List<ComicChapterEntity>>.seeded([]);

  final currentChapterSubject =
      BehaviorSubject<ComicChapterEntity?>.seeded(null);

  final pageController = PageController();

  final _preloadDebounce = Debounce(milliseconds: 300);

  final isMenuVisibleSubject = BehaviorSubject<bool>.seeded(false);

  final isOpenDrawerSubject = BehaviorSubject<bool>.seeded(false);

  final isFavoriteSubject = BehaviorSubject<bool>.seeded(false);

  ReadComicBloc(this.ref, {required ReadComicArgument args}) {
    _args = args;
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    comicChaptersSubject.close();
    pageController.dispose();
    currentChapterSubject.close();
    _preloadDebounce.dispose();
    isMenuVisibleSubject.close();
    isOpenDrawerSubject.close();
    isFavoriteSubject.close();
  }

  void _init() {
    comicChaptersSubject.value = _args.listChapter;
    _handleLoadFirstChapter();
    _getFavoriteStatus();
  }

  void _handleLoadFirstChapter() {
    final selectedIndex = comicChaptersSubject.value.indexWhere(
      (chapter) => chapter.id == selectedChapterId,
    );
    if (selectedIndex != -1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        pageController.jumpToPage(selectedIndex);
      });

      onPageChanged(selectedIndex);
    } else {
      currentChapterSubject.value = comicChaptersSubject.value[0];
      preloadChapters(0);
    }
  }

  void onPageChanged(int page) {
    if (page < 0 || page >= comicChaptersSubject.value.length) return;
    currentChapterSubject.value = comicChaptersSubject.value[page];
    _preloadDebounce.run(() {
      preloadChapters(page);
    });
  }

  Future<void> preloadChapters(int currentIndex) async {
    final List<Future<void>> tasks = [];

    // 1. Xác định Start: (Hiện tại - 2), nhưng không được nhỏ hơn 0
    int start = currentIndex - 2;
    if (start < 0) start = 0;

    // 2. Xác định End: (Hiện tại + 2), nhưng không được vượt quá phần tử cuối
    int end = currentIndex + 2;
    if (end >= comicChaptersSubject.value.length) {
      end = comicChaptersSubject.value.length - 1;
    }

    // 3. Loop trong khoảng [start -> end] (Bao gồm cả previous, current, next)
    for (int i = start; i <= end; i++) {
      final chapterItem = comicChaptersSubject.value[i];

      // Chỉ tải nếu trong Cache CHƯA CÓ
      if (chapterItem.pages.isEmpty) {
        // Lưu ý: task này nên chạy async độc lập,
        // add vào list để dùng Future.wait chờ tất cả (nếu muốn)
        tasks.add(
          _fetchAndCache(
            chapterItem.id,
          ),
        );
      }
    }

    // 4. Kích hoạt tải đồng thời
    if (tasks.isNotEmpty) {
      await Future.wait(tasks);
    }
  }

  Future<void> _fetchAndCache(String id) async {
    // Gọi Repository tải data
    final res = await _fetchChapter(chapterId: id);
    if (res != null) {
      final currentChapters = List<ComicChapterEntity>.from(
        comicChaptersSubject.value,
      );

      final index = currentChapters.indexWhere((chapter) => chapter.id == id);
      if (index != -1) {
        currentChapters[index] = currentChapters[index].copyWith(
          pages: res.pages,
        );
        comicChaptersSubject.value = currentChapters;
      }
    }
  }

  Future<ComicChapterEntity?> _fetchChapter({
    required String chapterId,
  }) async {
    final id = chapterId.split('||').first;
    final res = await networkApiService.comicRepository.getContents(
      id,
    );
    if (isDispose) return null;
    return res.when(
      success: (data) {
        final chapter = data.data;
        if (chapter == null) return null;
        return chapter.toEntity();
      },
      error: (error) {
        logger.e('Error fetching chapter: ${error.errorMessage}');
        return null;
      },
      handled: () {
        return null;
      },
    );
  }

  bool isCurrentPage(String chapterId) {
    final currentPageIndex = pageController.page?.toInt();
    if (currentPageIndex == null) return false;
    final currentChapterId = comicChaptersSubject.value[currentPageIndex].id;
    return chapterId == currentChapterId;
  }

  bool onAfterExitReadStory() {
    final isMenuVisible = isMenuVisibleSubject.value;
    if (isMenuVisible) {
      onToggleMenuVisibility();
      return false;
    }

    final isDrawerOpen = isOpenDrawerSubject.value;
    if (isDrawerOpen) {
      onTapToggleDrawer();
      return false;
    }

    return true;
  }

  void onToggleMenuVisibility() {
    isMenuVisibleSubject.value = !isMenuVisibleSubject.value;
  }

  void onMenuInvisible() {
    if (!isMenuVisibleSubject.value) return;
    isMenuVisibleSubject.value = false;
  }

  void onTapLoadNewChapter() {}

  int get currentChapterIndex {
    return pageController.page?.toInt() ?? 0;
  }

  void onTapToggleDrawer() {
    isOpenDrawerSubject.value = !isOpenDrawerSubject.value;
    if (isOpenDrawerSubject.value && isMenuVisibleSubject.value) {
      isMenuVisibleSubject.value = false;
    }
  }

  void onTapChapterIndex(int index) {
    pageController.jumpToPage(index);
    isOpenDrawerSubject.value = false;
  }

  void onTapNextPage() {
    final currentPage = pageController.page?.toInt() ?? 0;
    if (currentPage < comicChaptersSubject.value.length - 1) {
      pageController.jumpToPage(
        currentPage + 1,
      );
    }
  }

  void onTapPreviousPage() {
    final currentPage = pageController.page?.toInt() ?? 0;
    if (currentPage > 0) {
      pageController.jumpToPage(
        currentPage - 1,
      );
    }
  }

  Future<void> upsertBookLocal({
    required String chapterId,
    required double scrollOffset,
    required String lastReadTime,
    required List<ListChapterEntity> listChapters,
  }) async {
    final currentBook = await localApiService.bookRepository.getBookById(
      storyId,
    );
    if (currentBook == null) {
      logger.e(
        'Failed to upsert book to local, book not found for storyId: ${storyId}',
      );
      return;
    }
    BookEntity newBook = currentBook.copyWith(
      currentChapterId: chapterId,
      scrollOffset: scrollOffset,
      lastReadTime: lastReadTime,
      timeStamp: DateTime.now().toIso8601String(),
    );

    final isSameListChapters = listEquals(
      listChapters,
      currentBook.listChapters,
    );

    if (!isSameListChapters) {
      newBook = newBook.copyWith(
        listChapters: listChapters,
      );
    }

    await localApiService.bookRepository.upsertBook(
      newBook,
      isHasUpdateListChapter: !isSameListChapters,
    );
  }

  void onTapFavoriteStory() async {
    final currentStatus = isFavoriteSubject.value;
    final newStatus = !currentStatus;

    final bookEntityLocal =
        await localApiService.bookRepository.getBookById(storyId);

    final newBookEntity = bookEntityLocal?.copyWith(
      isFavorite: newStatus,
    );

    localApiService.bookRepository
        .upsertBook(
      newBookEntity!,
      isHasUpdateListChapter: false,
    )
        .then((_) {
      if (isDispose) return;
      isFavoriteSubject.value = newStatus;
    });
  }

  Future<void> _getFavoriteStatus() async {
    final bookEntityLocal =
        await localApiService.bookRepository.getBookById(storyId);
    final isFavorite = bookEntityLocal?.isFavorite ?? false;
    isFavoriteSubject.value = isFavorite;
  }
}
