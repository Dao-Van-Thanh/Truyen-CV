import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/constants/size_box.dart';
import 'package:flutter_template/features/library/widgets/book_banner_card.dart';
import 'package:flutter_template/features/library/widgets/library_bookmarks_item.dart';
import 'package:flutter_template/features/library/widgets/library_bookmarks_page_slider.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/widgets/empty/app_empty_state.dart';

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
          return AppEmptyState(title: t.libraryScreen.listBookmarksEmpty);
        }

        if (itemCount <= 3) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: itemCount,
            separatorBuilder: (_, __) => SizedBoxConstants.s12,
            itemBuilder: (context, index) {
              final book = list[index];
              return BookBannerCard(
                book: book,
                onTap: () => bloc.onTapReadStory(book),
                onLongPress: () => bloc.onTapLongPressStory(book),
              );
            },
          );
        }

        final top3Items = list.take(3).toList();
        final remainingItems = list.skip(3).toList();

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBoxConstants.s16,
                  LibraryBookmarksPageSlider(top3Items: top3Items),
                  SizedBoxConstants.s16,
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: heightItem,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return LibraryBookmarksItem(
                      item: remainingItems[index],
                    );
                  },
                  childCount: remainingItems.length,
                ),
              ),
            ),
            // Padding bottom safe area
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        );
      },
    );
  }
}
