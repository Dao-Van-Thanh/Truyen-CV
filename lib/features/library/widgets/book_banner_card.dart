// book_banner_card.dart
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_template/constants/constants.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:flutter_template/shared/utilities/datetime.dart';
import 'package:flutter_template/shared/widgets/gesture_detector/app_gesture_detector.dart';
import 'package:flutter_template/shared/widgets/story/story_image.dart';
import 'package:flutter_template/shared/widgets/text/realtime_time_ago.dart';

class BookBannerCard extends StatelessWidget {
  final BookEntity book;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const BookBannerCard({
    super.key,
    required this.book,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return AppGestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        height: 130,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Blur
            Positioned.fill(
              child: Transform.scale(
                scale: 1.1,
                child: ImageFiltered(
                  imageFilter: ui.ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                  child: StoryImage(
                    imageUrl: book.storyModel.thumb ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
            // Content Overlay
            Positioned.fill(
              child: Container(
                padding: EdgeInsetsConstants.all8,
                alignment: Alignment.center,
                color: Colors.black.withValues(alpha: 0.2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Book Cover
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
                        child: StoryImage(
                          imageUrl: book.storyModel.thumb ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBoxConstants.s16,
                    // Info
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  book.storyModel.name ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBoxConstants.s4,
                                Text(
                                  book.lastReadChapter?.name ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  book.readProgressPercent,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              RealtimeTimeAgo(
                                targetTime: DatetimeUtil.parseIsoToDateTime(
                                      book.lastReadTime,
                                    ) ??
                                    DateTime.now(),
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
