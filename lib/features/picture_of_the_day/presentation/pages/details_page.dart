import 'package:flutter/material.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/image_or_video_widget.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/picture_summary.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    required this.picture,
    super.key,
  });

  final PictureEntity picture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ImageOrVideoWidget(
              isVideo: picture.isVideo,
              url: picture.url,
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(top: 16),
          ),
          SliverToBoxAdapter(
            child: PictureSummary(picture: picture),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(top: 16),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text(picture.explanation),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(top: 32),
          ),
        ],
      ),
    );
  }
}
