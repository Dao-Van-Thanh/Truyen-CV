import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/i18n/strings.g.dart';

class ComicReaderImage extends StatefulWidget {
  final String imageUrl;

  const ComicReaderImage({
    super.key,
    required this.imageUrl,
  });

  @override
  State<ComicReaderImage> createState() => _ComicReaderImageState();
}

class _ComicReaderImageState extends State<ComicReaderImage> {
  int _retryKey = 0;

  Future<void> _handleRetry() async {
    await CachedNetworkImage.evictFromCache(widget.imageUrl);
    if (mounted) {
      setState(() {
        _retryKey++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black,
          child: CachedNetworkImage(
            key: ValueKey('${widget.imageUrl}_$_retryKey'),
            imageUrl: widget.imageUrl,
        fit: BoxFit.fitWidth,
        alignment: Alignment.topCenter,
            fadeInDuration: Duration.zero,
            fadeOutDuration: Duration.zero,
            placeholder: (context, url) => const SizedBox(
              height: 300,
              width: double.infinity,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            ),
            errorWidget: (context, url, error) => SizedBox(
              height: 300,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.broken_image_rounded,
                    color: Colors.white54,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.t.renderImage.loadFail,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _handleRetry,
                    icon: const Icon(
                      Icons.refresh,
                      size: 18,
                      color: Colors.white,
                    ),
                    label: Text(
                      context.t.renderImage.loadAgain,
                      style: TextStyle(color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
          ),
        ),
      ),
    );
  }
}
