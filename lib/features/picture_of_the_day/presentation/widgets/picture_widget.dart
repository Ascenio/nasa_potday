import 'package:flutter/material.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';

class PictureWidget extends StatelessWidget {
  const PictureWidget({
    required this.picture,
    super.key,
  });

  final PictureEntity picture;

  @override
  Widget build(BuildContext context) {
    return switch (picture.isVideo) {
      true => const Placeholder(
          child: SizedBox.expand(
            child: Center(child: Text('Video is not implemented yet')),
          ),
        ),
      false => Image.network(picture.url.toString()),
    };
  }
}
