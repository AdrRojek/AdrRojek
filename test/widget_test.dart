import 'package:adrrojek_cv/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  VisibilityDetectorController.instance.updateInterval = Duration.zero;

  testWidgets('portfolio shows recruiter snapshot', (tester) async {
    tester.view.physicalSize = const Size(1200, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AdrRojekApp());
    await tester.pump();

    expect(find.text('Adrian Rojek'), findsWidgets);
    expect(find.text('Computer Science student'), findsWidgets);
    expect(find.textContaining('Open to internships and jobs'), findsWidgets);
    expect(find.textContaining('Copy email'), findsWidgets);
  });
}
