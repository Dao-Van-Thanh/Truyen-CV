import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCacheNetworkImage extends StatelessWidget {
  final String imageUrl;
  final Widget Function(BuildContext, String)? placeholderBuilder;
  final Widget Function(BuildContext, String, dynamic)? errorBuilder;
  final BoxFit fit;
  final double? width;
  final double? height;
  final int? memCacheWidth;

  const AppCacheNetworkImage({
    super.key,
    required this.imageUrl,
    this.placeholderBuilder,
    this.errorBuilder,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.memCacheWidth,
  });

  @override
  Widget build(BuildContext context) {
    final int? assetCacheWidth = memCacheWidth ??
        ((width != null && width!.isFinite) ? (width! * 2).toInt() : null);
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      memCacheWidth: memCacheWidth,
      placeholder: placeholderBuilder ??
          (context, url) => Image.asset(
                'assets/images/image_default.jpeg',
                width: width,
                height: height,
                fit: fit,
                cacheWidth: assetCacheWidth,
              ),
      errorWidget: errorBuilder ??
          (context, url, error) => Image.asset(
                'assets/images/image_default.jpeg',
                width: width,
                height: height,
                fit: fit,
                cacheWidth: assetCacheWidth,
              ),
    );
  }
}
