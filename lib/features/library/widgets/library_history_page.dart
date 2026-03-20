import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truyen_cv/bloc/bloc_provider.dart';
import 'package:truyen_cv/bloc/rx/obs_builder.dart';
import 'package:truyen_cv/constants/common.dart';
import 'package:truyen_cv/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:truyen_cv/features/library/extension/library_extension.dart';
import 'package:truyen_cv/features/library/widgets/library_history_item.dart';
import 'package:truyen_cv/i18n/strings.g.dart';
import 'package:truyen_cv/shared/utilities/datetime.dart';
import 'package:truyen_cv/shared/widgets/empty/app_empty_state.dart';
import 'package:truyen_cv/shared/widgets/grouped_sliver_list/app_grouped_sliver_list.dart';
import 'package:truyen_cv/shared/widgets/refresh_indicator/app_refresh_indicator.dart';

class LibraryHistoryPage extends ConsumerWidget {
  const LibraryHistoryPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.library);
    final t = context.t;
    return AppRefreshIndicator(
      onRefresh: bloc.onRefreshHistory,
      child: ObsBuilder(
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
      ),
    );
  }
}
