import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageOrVideoWidget extends StatelessWidget {
  const ImageOrVideoWidget({
    required this.url,
    required this.isVideo,
    super.key,
  });

  final Uri url;
  final bool isVideo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final brightness = MediaQuery.platformBrightnessOf(context);
    final onSurfaceColor = switch (brightness) {
      Brightness.dark => Colors.black,
      Brightness.light => Colors.white,
    };
    final surfaceColor = Theme.of(context).dividerColor;
    return Hero(
      tag: url,
      child: SizedBox(
        height: size.height / 3,
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: url.toString(),
              width: double.infinity,
              height: size.height / 3,
              memCacheHeight: size.height ~/ 3,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => ColoredBox(
                color: surfaceColor,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Could not show the image',
                    )
                  ],
                ),
              ),
              progressIndicatorBuilder: (_, __, progress) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        onSurfaceColor,
                        surfaceColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [
                        0,
                        progress.progress ?? 0,
                      ],
                    ),
                  ),
                );
              },
            ),
            if (isVideo) Center(child: Image.asset('assets/youtube-logo.png')),
          ],
        ),
      ),
    );
  }
}
