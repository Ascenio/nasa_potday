import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_potday/features/picture_of_the_day/presentation/widgets/loading_widget.dart';
import 'package:nasa_potday/main.dart';

import 'scroll_helpers.dart';

void main() {
  testWidgets('should load more pictures when it gets to the end of the screen',
      (tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.byType(LoadingWidget),
      500,
      scrollable: find.byType(Scrollable),
    );
    await tester.pumpAndSettle();
    expectListViewHasNItems(tester: tester, itemCount: 14);
  });
}
