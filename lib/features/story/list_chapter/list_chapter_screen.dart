import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_sliver_list/super_sliver_list.dart';
import 'package:truyen_cv/bloc/bloc_provider.dart';
import 'package:truyen_cv/bloc/rx/obs_builder.dart';
import 'package:truyen_cv/constants/constants.dart';
import 'package:truyen_cv/features/story/list_chapter/enum/list_sort_enum.dart';
import 'package:truyen_cv/features/story/list_chapter/widget/list_chapter_app_bar.dart';
import 'package:truyen_cv/i18n/strings.g.dart';
import 'package:truyen_cv/shared/widgets/scroll_bar/app_raw_scrollbar.dart';

class ListChapterScreen extends ConsumerWidget {
  const ListChapterScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.listChapter);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ListChapterAppBar(),
      ),
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: ObsBuilder(
        streams: [
          bloc.listChapterSubject,
          bloc.listSortSubject,
        ],
        builder: (context) {
          final sortEnum = bloc.listSortSubject.value;
          final listChapter = sortEnum == ListSortEnum.sortOld
              ? bloc.listChapterSubject.value
              : bloc.listChapterSubject.value.reversed.toList();

          return Column(
            children: [
              Divider(height: 1),
              _header(
                context,
                sortEnum: sortEnum,
                count: bloc.listChapterTemp.length,
                onSelectedSort: bloc.onSelectedSort,
              ),
              Divider(height: 1),
              Expanded(
                child: AppRawScrollBar(
                  controller: bloc.scrollController,
                  child: SuperListView.separated(
                    controller: bloc.scrollController,
                    itemCount: listChapter.length,
                    separatorBuilder: (_, __) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final chapter = listChapter[index];
                      return _buildItem(
                        chapter.name,
                        onTap: () {
                          bloc.onTapChapter(chapter);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: ObsBuilder(
        streams: [bloc.isContinueReadingSubject],
        builder: (context) {
          final isShow = bloc.isContinueReadingSubject.value;
          if (!isShow) return const SizedBox.shrink();

          return FloatingActionButton(
            onPressed: () {
              bloc.onTapContinueReading();
            },
            child: const Icon(Icons.fast_forward),
          );
        },
      ),
    );
  }

  Widget _buildItem(String chapterName, {required VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsetsConstants.vertical12 + EdgeInsetsConstants.horizontal20,
        child: Text(
          chapterName,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _header(
    BuildContext context, {
    required ListSortEnum sortEnum,
    required int count,
    double percent = 100.0,
    required void Function(ListSortEnum) onSelectedSort,
  }) {
    final t = context.t;

    final isSortOld = sortEnum == ListSortEnum.sortOld;
    final theme = Theme.of(context);
    final colorSelected = theme.colorScheme.primary;
    final contentLoaded = Row(
      children: [
        Expanded(
          child: Text(
            '$count ${t.storyDetail.chapters} - ${percent.toStringAsFixed(0)}%',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 16),
        PopupMenuButton<ListSortEnum>(
          menuPadding: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.sort),
          onSelected: onSelectedSort,
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: ListSortEnum.sortNew,
                child: Row(
                  children: [
                    Text(
                      t.listChapter.sortNew,
                      style: !isSortOld
                          ? TextStyle(
                              color: colorSelected,
                              fontWeight: FontWeight.w600,
                            )
                          : null,
                    ),
                    if (!isSortOld) ...[
                      const SizedBox(width: 8),
                      Icon(
                        Icons.check,
                        size: 16,
                        color: colorSelected,
                      ),
                    ],
                  ],
                ),
              ),
              PopupMenuItem(
                value: ListSortEnum.sortOld,
                child: Row(
                  children: [
                    Text(
                      t.listChapter.sortOld,
                      style: isSortOld
                          ? TextStyle(
                              color: colorSelected,
                              fontWeight: FontWeight.w600,
                            )
                          : null,
                    ),
                    if (isSortOld) ...[
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.blue,
                      ),
                    ],
                  ],
                ),
              ),
            ];
          },
        ),
      ],
    );

    return Container(
      padding: EdgeInsetsConstants.horizontal20,
      alignment: Alignment.centerLeft,
      child: contentLoaded,
    );
  }
}
