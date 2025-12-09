import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/book_entity.dart';
import 'package:flutter_template/shared/widgets/cache_network_image/app_cache_network_image.dart';
import 'package:flutter_template/shared/widgets/gesture_detector/app_gesture_detector.dart';

class LibraryHistoryItem extends ConsumerWidget {
  final BookEntity item;
  const LibraryHistoryItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);
    final name = item.storyModel.name ?? '';
    final thumbUrl = item.storyModel.thumb ?? '';
    final currentChapter = item.lastReadChapter?.name ?? '';
    final bloc = ref.read(BlocProvider.library);
    return AppGestureDetector(
      onTap: () {
        bloc.onTapReadStory(item);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: AppCacheNetworkImage(
                imageUrl: thumbUrl,
                width: 70,
                height: 95,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currentChapter,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
