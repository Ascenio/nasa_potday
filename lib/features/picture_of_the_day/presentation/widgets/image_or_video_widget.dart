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
    return switch (isVideo) {
      true => const Placeholder(
          child: SizedBox.expand(
            child: Center(child: Text('Video is not implemented yet')),
          ),
        ),
      false => Image.network(
          url.toString(),
        ),
    };
  }
}
