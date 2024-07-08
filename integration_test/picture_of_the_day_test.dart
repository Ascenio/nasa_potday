import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_potday/core/clock/system_clock.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/pages/details_page.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/pages/picture_of_the_day_page.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/loading_widget.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/picture_widget.dart';
import 'package:nasa_potday/main.dart';

import 'scroll_helpers.dart';

void main() {
  testWidgets('should display the picture of the day at the top',
      (tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();
    final picture =
        tester.firstWidget<PictureWidget>(find.byType(PictureWidget)).picture;
    expect(picture.date, const SystemClock().today());
  });

  testWidgets('should open the details page when tapping at a picture',
      (tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byType(PictureWidget).first);
    await tester.pumpAndSettle();
    expect(find.byType(DetailsPage), findsOne);
    expect(find.byType(PictureOfTheDayPage), findsNothing);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(DetailsPage), findsNothing);
    expect(find.byType(PictureOfTheDayPage), findsOneWidget);
  });

  testWidgets('should display 7 pictures per page', (tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();
    expectListViewSeparatedHasNItems(tester: tester, itemCount: 7);
  });

  testWidgets('should search by date', (tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.today));
    await tester.pumpAndSettle();
    await tester.tap(find.text(const SystemClock().today().day.toString()));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.byType(PictureWidget), findsOne);
    await tester.tap(find.byIcon(Icons.chevron_left));
    await tester.pumpAndSettle();
    expectListViewSeparatedHasNItems(tester: tester, itemCount: 7);
  });

  testWidgets(
      'should display the last item of the page as a picture of 6 days before',
      (tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.byType(LoadingWidget),
      500,
      scrollable: find.byType(Scrollable),
    );
    final lastPicture = tester
        .widgetList<PictureWidget>(find.byType(PictureWidget))
        .last
        .picture;
    await tester.pumpAndSettle();
    expect(
      lastPicture.date,
      const SystemClock().today().subtract(const Duration(days: 7 - 1)),
    );
  });
}
