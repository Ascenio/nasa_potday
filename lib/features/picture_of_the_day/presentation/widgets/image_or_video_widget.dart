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
    return SizedBox(
      height: size.height / 3,
      child: switch (isVideo) {
        true => Container(
            width: double.infinity,
            color: Colors.black,
            child: Image.asset('assets/youtube-logo.png'),
          ),
        false => Image.network(
            url.toString(),
            width: double.infinity,
            height: size.height / 3,
            cacheHeight: size.height ~/ 3,
            fit: BoxFit.cover,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: frame == null ? 0 : 1,
                child: child,
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              var progress = 0.0;
              if (loadingProgress != null &&
                  loadingProgress.expectedTotalBytes != 0) {
                progress = loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!;
              }

              return DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [
                      Colors.grey,
                      Colors.white,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [
                      0,
                      progress,
                    ],
                  ),
                ),
                child: child,
              );
            },
          ),
      },
    );
  }
}
