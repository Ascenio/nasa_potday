import 'package:flutter/material.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/pages/details_page.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/date_widget.dart';

class PictureWidget extends StatelessWidget {
  const PictureWidget({
    required this.picture,
    super.key,
  });

  final PictureEntity picture;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => DetailsPage(picture: picture)),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: picture.url,
            child: switch (picture.isVideo) {
              true => const Placeholder(
                  child: SizedBox.expand(
                    child: Center(child: Text('Video is not implemented yet')),
                  ),
                ),
              false => Image.network(
                  picture.url.toString(),
                ),
            },
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(picture.title),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: DateWidget(date: picture.date),
          ),
        ],
      ),
    );
  }
}
