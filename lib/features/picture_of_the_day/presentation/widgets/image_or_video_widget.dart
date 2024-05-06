import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        true => const Placeholder(
            child: SizedBox.expand(
              child: Center(child: Text('Video is not implemented yet')),
            ),
          ),
        false => Image.network(
            url.toString(),
            width: double.infinity,
            height: size.height / 3,
            cacheHeight: size.height ~/ 3,
            fit: BoxFit.cover,
          ),
      },
    );
  }
}
