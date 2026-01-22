import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_template/shared/widgets/cache_network_image/app_cache_network_image.dart';

class StoryImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double radius;

  //only for AppCacheNetworkImage
  final int? memCacheWidth;
  final CustomAbove? customAbove;

  const StoryImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.radius = 0,
    this.memCacheWidth,
    this.customAbove,
  });

  @override
  Widget build(BuildContext context) {
    final path = imageUrl ?? '';
    Widget imageWidget;

    if (path.isEmpty) {
      imageWidget = _buildPlaceholder();
    }
    // 1. Trường hợp ONLINE
    else if (path.startsWith('http') || path.startsWith('https')) {
      imageWidget = AppCacheNetworkImage(
        imageUrl: path,
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: memCacheWidth,
      );
    } else if (path.startsWith('assets/')) {
      imageWidget = Image.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      );
    } else {
      imageWidget = Image.file(
        File(path),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      );
    }
    if (radius > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _buildPlaceholder() {
    final int? assetCacheWidth = memCacheWidth ??
        ((width != null && width!.isFinite) ? (width! * 2).toInt() : null);
    return Image.asset(
      'assets/images/image_default.jpeg',
      width: width,
      height: height,
      fit: fit,
      cacheWidth: assetCacheWidth,
    );
  }
}
