import 'package:flutter/material.dart';
import 'package:flutter_template/dependency/local_api/repository/book/entities/story_entity.dart';
import 'package:flutter_template/shared/widgets/gesture_detector/app_gesture_detector.dart';
import 'package:flutter_template/shared/widgets/story/story_image.dart';

class StoryGridItem extends StatelessWidget {
  final StoryEntity story;
  final VoidCallback onTap;
  const StoryGridItem({
    super.key,
    required this.story,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final dpr = MediaQuery.devicePixelRatioOf(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final tileWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;

        final padding = tileWidth < 120 ? 6.0 : 8.0;
        final titleFontSize = (tileWidth / 11).clamp(11.0, 13.5);
        final metaFontSize = (titleFontSize - 1).clamp(10.0, 12.5);
        final iconSize = (metaFontSize + 1).clamp(11.0, 14.0);

        final memCacheWidth = (tileWidth * dpr).round().clamp(180, 640).toInt();

        return Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black54
                    : Colors.grey.withValues(alpha: 0.2),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          child: AppGestureDetector(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 3 / 4,
                  child: StoryImage(
                    imageUrl: story.thumb,
                    fit: BoxFit.cover,
                    memCacheWidth: memCacheWidth,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          story.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: titleFontSize,
                            height: 1.15,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            if (story.rating != null)
                              Flexible(
                                child: Text(
                                  '★ ${story.rating}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.6),
                                    fontSize: metaFontSize,
                                    height: 1.1,
                                  ),
                                ),
                              ),
                            if (story.rating != null && story.viewed != null)
                              const SizedBox(width: 8),
                            if (story.viewed != null)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.remove_red_eye,
                                    size: iconSize,
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.6),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    story.viewed!,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.6),
                                      fontSize: metaFontSize,
                                      height: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          story.process,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.6),
                            fontSize: metaFontSize,
                            height: 1.1,
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
      },
    );
  }
}
