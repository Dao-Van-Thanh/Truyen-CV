import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppCacheNetworkImage extends StatelessWidget {
  final String imageUrl;
  final Widget Function(BuildContext, String)? placeholderBuilder;
  final Widget Function(BuildContext, String, dynamic)? errorBuilder;
  final BoxFit fit;
  final double? width;
  final double? height;

  const AppCacheNetworkImage({
    super.key,
    required this.imageUrl,
    this.placeholderBuilder,
    this.errorBuilder,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      placeholder: placeholderBuilder ??
          (context, url) => Container(
                color: isDark ? Colors.grey[800] : Colors.grey[300],
                alignment: Alignment.center,
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: theme.colorScheme.primary,
                  size: 30,
                ),
              ),
      errorWidget: errorBuilder ??
          (context, url, error) => Container(
                color: isDark ? Colors.grey[800] : Colors.grey[300],
                alignment: Alignment.center,
              ),
    );
  }
}
