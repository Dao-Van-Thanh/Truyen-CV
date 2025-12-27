import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:flutter_template/features/library/widgets/book_banner_card.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LibraryBookmarksPageSlider extends ConsumerWidget {
  final List<BookEntity> top3Items;
  const LibraryBookmarksPageSlider({super.key, required this.top3Items});

  @override
  Widget build(BuildContext context, ref) {
    if (top3Items.isEmpty) return const SizedBox.shrink();
    final bloc = ref.read(BlocProvider.library);

    return SizedBox(
      height: 130,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 130,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          enlargeFactor: 0.3,
          aspectRatio: 2.0,
        ),
        items: top3Items.map((book) {
          // Tái sử dụng Widget đã tách
          return BookBannerCard(
            book: book,
            onTap: () => bloc.onTapReadStory(book),
            onLongPress: () => bloc.onTapLongPressStory(book),
          );
        }).toList(),
      ),
    );
  }
}
