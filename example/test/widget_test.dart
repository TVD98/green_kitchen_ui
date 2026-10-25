import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_kitchen_ui/green_kitchen_ui.dart';
import 'package:green_kitchen_ui_example/main.dart';

void main() {
  testWidgets('gallery renders and toggles dark mode', (tester) async {
    await tester.pumpWidget(const GalleryApp());

    expect(find.text('Green Kitchen UI'), findsOneWidget);
    expect(find.text('Primary'), findsOneWidget);

    Brightness brightness() =>
        Theme.of(tester.element(find.text('Primary'))).brightness;
    expect(brightness(), Brightness.light);

    // The first AppSwitch is the dark-mode toggle in the header.
    await tester.tap(find.byType(AppSwitch).first);
    await tester.pumpAndSettle();
    expect(brightness(), Brightness.dark);
  });
}
