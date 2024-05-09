import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_potday/features/picture_of_the_day/domain/entities/picture_entity.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/pages/details_page.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/image_or_video_widget.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/picture_summary.dart';

void main() {
  final picture = PictureEntity(
    url: Uri.parse('https://img.youtube.com/vi/l36UkYtq6m0/0.jpg'),
    explanation:
        "What would it look like to circle a black hole? If the black hole was surrounded by a swirling disk of glowing and accreting gas, then the great gravity of the black hole would deflect light emitted by the disk to make it look very unusual. The featured animated video gives a visualization. The video starts with you, the observer, looking toward the black hole from just above the plane of the accretion disk.  Surrounding the central black hole is a thin circular image of the orbiting disk that marks the position of the photon sphere -- inside of which lies the black hole's event horizon.  Toward the left, parts of the large main image of the disk appear brighter as they move toward you. As the video continues, you loop over the black hole, soon looking down from the top, then passing through the disk plane on the far side, then returning to your original vantage point. The accretion disk does some interesting image inversions -- but never appears flat. Visualizations such as this are particularly relevant today as black holes are being imaged in unprecedented detail by the Event Horizon Telescope.   Singularity Impressive: It's Black Hole Week at NASA!",
    title: 'Visualization: A Black Hole Accretion Disk',
    date: DateTime(2024, 5, 8),
    isVideo: true,
  );

  Future<void> setupPage({required WidgetTester tester}) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DetailsPage(
          picture: picture,
        ),
      ),
    );
  }

  testWidgets('should display the image', (tester) async {
    await setupPage(tester: tester);
    expect(find.byType(ImageOrVideoWidget), findsOne);
  });

  testWidgets('should display the summary', (tester) async {
    await setupPage(tester: tester);
    expect(find.byType(PictureSummary), findsOne);
  });

  testWidgets('should display the explanation', (tester) async {
    await setupPage(tester: tester);
    expect(find.text(picture.explanation), findsOne);
  });
}
