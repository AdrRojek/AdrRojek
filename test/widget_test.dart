import 'package:adrrojek_cv/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('portfolio shows name and key sections', (tester) async {
    tester.view.physicalSize = const Size(1200, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AdrRojekApp());
    await tester.pump();

    expect(find.text('Adrian Rojek'), findsWidgets);
    expect(find.text('Computer Science student'), findsOneWidget);
    expect(find.textContaining('Search'), findsWidgets);
  });
}
