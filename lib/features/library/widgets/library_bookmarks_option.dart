import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/constants/constants.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/widgets/cache_network_image/app_cache_network_image.dart';
import 'package:flutter_template/shared/widgets/gesture_detector/app_gesture_detector.dart';
import 'package:flutter_template/shared/widgets/text%20copy/highlight_text.dart';

class LibraryBookmarksOption extends ConsumerWidget {
  final BookEntity item;
  final VoidCallback onTapViewInfo;
  final void Function(bool isRemove) onTapAddOrRemoveBookmark;
  const LibraryBookmarksOption(
    this.item, {
    super.key,
    required this.onTapViewInfo,
    required this.onTapAddOrRemoveBookmark,
  });

  @override
  Widget build(BuildContext context, ref) {
    final t = context.t;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: AppCacheNetworkImage(
                      imageUrl: item.storyModel.thumb ?? '',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(
                                      alpha: 0.1,
                                    ),
                              ),
                            ),
                            child: Text(
                              item.storyModel.name ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(
                                      alpha: 0.1,
                                    ),
                              ),
                            ),
                            child: Text(
                              item.storyModel.author ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            HighlightText(
              t.libraryScreen.optionsBottomSheet.lastChapter(
                chapterName: item.lastReadChapter?.name ?? '',
              ),
              highlightTexts: [item.lastReadChapter?.name ?? ''],
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.start,
              highlightStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            HighlightText(
              t.libraryScreen.optionsBottomSheet.totalChapters(
                chapterCount: item.listChapters.length,
              ),
              highlightTexts: [
                item.listChapters.length.toString(),
              ],
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.start,
              highlightStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBoxConstants.s16,
            AppGestureDetector(
              onTap: () {
                if (item.isFavorite) {
                  _onTapConfirmUnfavorite(context);
                } else {
                  onTapAddOrRemoveBookmark.call(false);
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsetsConstants.vertical12 +
                    EdgeInsetsConstants.horizontal16,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onSurface.withValues(
                          alpha: 0.1,
                        ),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(
                      item.isFavorite
                          ? Icons.bookmark_remove_outlined
                          : Icons.bookmark_add_outlined,
                      size: 24,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Text(
                      item.isFavorite
                          ? t.libraryScreen.optionsBottomSheet.removeBookmark
                          : t.libraryScreen.optionsBottomSheet.addBookmark,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBoxConstants.s8,
            AppGestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                onTapViewInfo();
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsetsConstants.vertical12 +
                    EdgeInsetsConstants.horizontal16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.primary.withValues(
                        alpha: 0.1,
                      ),
                ),
                child: Text(
                  t.libraryScreen.optionsBottomSheet.viewInfo,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapConfirmUnfavorite(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (modalContext) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context
                      .t.libraryScreen.optionsBottomSheet.confirmRemoveBookmark,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBoxConstants.s16,
                Row(
                  children: [
                    Expanded(
                      child: AppGestureDetector(
                        onTap: () {
                          Navigator.of(modalContext).pop();
                        },
                        child: Container(
                          padding: EdgeInsetsConstants.vertical12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(
                                    alpha: 0.1,
                                  ),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            context.t.common.cancel,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ),
                    SizedBoxConstants.s16,
                    Expanded(
                      child: AppGestureDetector(
                        onTap: () {
                          Navigator.of(modalContext).pop();
                          Navigator.of(context).pop();
                          onTapAddOrRemoveBookmark.call(true);
                        },
                        child: Container(
                          padding: EdgeInsetsConstants.vertical12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color:
                                Theme.of(context).colorScheme.error.withValues(
                                      alpha: 0.1,
                                    ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            context.t.common.confirm,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
