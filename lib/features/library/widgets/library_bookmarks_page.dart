import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/constants/size_box.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:flutter_template/dependency/network_api/story/filter/story_filter_response.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/features/library/widgets/library_bookmarks_item.dart';
import 'package:flutter_template/features/library/widgets/library_bookmarks_page_slider.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/utilities/string.dart';

class LibraryBookmarksPage extends ConsumerWidget {
  const LibraryBookmarksPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.library);
    final heightItem = MediaQuery.of(context).size.height * 0.27;
    final t = context.t;
    return ObsBuilder(
      streams: [bloc.listBookmarksSubject],
      builder: (context) {
        final list = bloc.listBookmarksSubject.value;
        final itemCount = list.length;
        if (itemCount == 0) {
          return Center(
            child: Text(
              t.libraryScreen.listBookmarksEmpty,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          );
        }

        final top3Items = itemCount >= 3 ? list.take(3).toList() : list;

        final remainingItems =
            itemCount > 3 ? list.skip(3).toList() : <BookEntity>[];

        return Column(
          children: [
            SizedBoxConstants.s16,
            LibraryBookmarksPageSlider(top3Items: top3Items),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                cacheExtent: 500,
                addRepaintBoundaries: true,
                addAutomaticKeepAlives: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: heightItem,
                ),
                itemCount: remainingItems.length,
                itemBuilder: (context, index) {
                  final item = remainingItems[index];
                  final storyData = StoryModel.fromJson(
                    jsonDecode(item.storyData) as Map<String, dynamic>,
                  );

                  final listChapters = StringUtilities.convertStringToListMap(
                          item.listChapterData)
                      .map((e) => ListChapterRes.fromJson(e))
                      .toList();

                  ListChapterRes? lastReadChapter =
                      listChapters.firstWhereOrNull(
                    (chapter) => chapter.id == item.currentChapterId,
                  );

                  if (lastReadChapter == null && listChapters.isNotEmpty) {
                    lastReadChapter = listChapters[0];
                  }

                  return LibraryBookmarksItem(
                    thumbUrl: storyData.thumb ?? '',
                    name: storyData.name ?? '',
                    currentChapter: lastReadChapter?.name ?? '',
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
