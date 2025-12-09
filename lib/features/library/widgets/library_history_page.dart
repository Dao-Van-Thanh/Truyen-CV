import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/dependency/network_api/story/filter/story_filter_response.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/features/library/widgets/library_history_item.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/utilities/datetime.dart';
import 'package:flutter_template/shared/utilities/string.dart';
import 'package:flutter_template/shared/widgets/grouped_sliver_list/app_grouped_sliver_list.dart';

class LibraryHistoryPage extends ConsumerWidget {
  const LibraryHistoryPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.library);
    final t = context.t;
    return ObsBuilder(
      streams: [bloc.listHistorySubject],
      builder: (context) {
        final data = bloc.listHistorySubject.value;
        return AppGroupedSliverList(
          data: data,
          groupBy: (item) {
            final lastReadDate = DatetimeUtil.parseIsoToDateTime(
              item.lastReadTime,
            );
            return DatetimeUtil.formatRelativeDate(lastReadDate, t);
          },
          titleBuilder: (context, title) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          },
          itemBuilder: (context, item) {
            final storyData = StoryModel.fromJson(
              jsonDecode(item.storyData) as Map<String, dynamic>,
            );

            final listChapters =
                StringUtilities.convertStringToListMap(item.listChapterData)
                    .map((e) => ListChapterRes.fromJson(e))
                    .toList();

            ListChapterRes? lastReadChapter = listChapters.firstWhereOrNull(
              (chapter) => chapter.id == item.currentChapterId,
            );

            if (lastReadChapter == null && listChapters.isNotEmpty) {
              lastReadChapter = listChapters[0];
            }

            return LibraryHistoryItem(
              thumbUrl: storyData.thumb ?? '',
              name: storyData.name ?? '',
              currentChapter: lastReadChapter?.name ?? '',
            );
          },
        );
      },
    );
  }
}
