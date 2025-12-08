import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/shared/widgets/cache_network_image/app_cache_network_image.dart';
import 'package:flutter_template/shared/widgets/gesture_detector/app_gesture_detector.dart';
import 'package:flutter_template/shared/widgets/story_list/entities/story_list_item_entity.dart';

class StoryListItem extends ConsumerWidget {
  final StoryListItemEntity story;
  final bool isCompact;
  const StoryListItem({super.key, required this.story, this.isCompact = false});

  @override
  Widget build(BuildContext context, ref) {
    final routerService = ref.read(AppService.router);
    final theme = Theme.of(context);
    return AppGestureDetector(
      onTap: () {
        routerService.push(RouteInput.storyDetail(storyId: story.storyId));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isCompact) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: AppCacheNetworkImage(
                  imageUrl: story.thumbUrl,
                  width: 70,
                  height: 95,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    story.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '★ ${story.rating}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.remove_red_eye,
                        size: 14,
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        story.viewed,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    story.process,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
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
