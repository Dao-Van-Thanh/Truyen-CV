import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/constants/constants.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:flutter_template/dependency/network_api/story/filter/story_filter_response.dart';
import 'package:flutter_template/dependency/network_api/story/list_chapter/list_chapter_res.dart';
import 'package:flutter_template/shared/utilities/datetime.dart';
import 'package:flutter_template/shared/utilities/string.dart';
import 'package:flutter_template/shared/widgets/cache_network_image/app_cache_network_image.dart';
import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_template/shared/widgets/text/realtime_time_ago.dart';

class LibraryBookmarksPageSlider extends ConsumerWidget {
  final List<BookEntity> top3Items;
  const LibraryBookmarksPageSlider({super.key, required this.top3Items});

  @override
  Widget build(BuildContext context, ref) {
    if (top3Items.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 130,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 130,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
          aspectRatio: 2.0,
        ),
        items: top3Items.map((book) {
          final storyData = StoryModel.fromJson(
            jsonDecode(book.storyData) as Map<String, dynamic>,
          );

          final listChapters =
              StringUtilities.convertStringToListMap(book.listChapterData)
                  .map((e) => ListChapterRes.fromJson(e))
                  .toList();

          ListChapterRes? lastReadChapter = listChapters.firstWhereOrNull(
            (chapter) => chapter.id == book.currentChapterId,
          );

          if (lastReadChapter == null && listChapters.isNotEmpty) {
            lastReadChapter = listChapters[0];
          }

          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Transform.scale(
                    scale: 1.1,
                    child: ImageFiltered(
                      imageFilter: ui.ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                      child: AppCacheNetworkImage(
                        imageUrl: storyData.thumb ?? '',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    padding: EdgeInsetsConstants.all8,
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.5),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: AspectRatio(
                            aspectRatio: 2 / 3,
                            child: AppCacheNetworkImage(
                              imageUrl: storyData.thumb ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBoxConstants.s16,
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      storyData.name ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBoxConstants.s8,
                                    Text(
                                      lastReadChapter?.name ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  RealtimeTimeAgo(
                                    targetTime: DatetimeUtil.parseIsoToDateTime(
                                          book.lastReadTime,
                                        ) ??
                                        DateTime.now(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
