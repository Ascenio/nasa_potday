import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

int _computeActualChildCount(int itemCount) {
  return max(0, itemCount * 2 - 1);
}

int listViewChildCount({
  required WidgetTester tester,
  required int itemCount,
}) {
  final listView = tester.widget<ListView>(find.byType(ListView));
  return listView.childrenDelegate.estimatedChildCount!;
}

void expectListViewHasNItems({
  required WidgetTester tester,
  required int itemCount,
}) {
  expect(
    listViewChildCount(tester: tester, itemCount: itemCount),
    _computeActualChildCount(itemCount),
  );
}
