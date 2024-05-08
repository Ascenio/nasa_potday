import 'package:flutter/widgets.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/date_widget.dart';

class PictureSummary extends StatelessWidget {
  const PictureSummary({
    required this.picture,
    super.key,
  });

  final PictureEntity picture;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
    );
  }
}
