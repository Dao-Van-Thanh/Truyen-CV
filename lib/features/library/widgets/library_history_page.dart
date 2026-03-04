import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/constants/common.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:flutter_template/features/library/extension/library_extension.dart';
import 'package:flutter_template/features/library/widgets/library_history_item.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/utilities/datetime.dart';
import 'package:flutter_template/shared/widgets/empty/app_empty_state.dart';
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

        if (data.isEmpty) {
          return AppEmptyState(title: t.libraryScreen.listHistoryEmpty);
        }

        final page = bloc.historyCurrentPage;
        final limit = CommonConstants.pageSize;
        final isLastPage = data.length < (page + 1) * limit;
        return AppGroupedSliverList<BookEntity>(
          data: data,
          onLoadMore: bloc.onLoadMoreHistory,
          onRefresh: bloc.onRefreshHistory,
          isLastPage: isLastPage,
          controller: bloc.historyScrollController,
          groupBy: (item) {
            final lastReadDate = DatetimeUtil.parseIsoToDateTime(
              item.lastReadTime,
            );
            return DatetimeUtil.formatRelativeDate(lastReadDate, t);
          },
          titleBuilder: (context, title) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          },
          itemBuilder: (context, item) {
            return LibraryHistoryItem(
              key: ValueKey(item.id),
              item: item,
              onPress: () => bloc.onTapReadStory(item),
              onLongPress: () => bloc.onTapLongPressStory(item),
            );
          },
        );
      },
    );
  }
}
