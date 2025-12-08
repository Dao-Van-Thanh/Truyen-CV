import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/shared/widgets/cache_network_image/app_cache_network_image.dart';
import 'package:flutter_template/shared/widgets/story_list/entities/story_list_item_entity.dart';

class StoryGridItem extends ConsumerWidget {
  final StoryListItemEntity story;
  const StoryGridItem({super.key, required this.story});

  @override
  Widget build(BuildContext context, ref) {
    final routerService = ref.read(AppService.router);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black54
                : Colors.grey.withValues(
                    alpha: 0.2,
                  ),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () {
          routerService.push(RouteInput.storyDetail(storyId: story.storyId));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 3 / 4,
              child: AppCacheNetworkImage(
                imageUrl: story.thumbUrl,
                fit: BoxFit.cover,
                memCacheWidth: 250,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        story.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            '★ ${story.rating}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.6),
                              fontSize: 11,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.remove_red_eye,
                              size: 12,
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.6),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              story.viewed,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.6),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      story.process,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        fontSize: 12,
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
