import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_kitchen_ui/green_kitchen_ui.dart';

/// Regression tests for bugs fixed when the package was split out of the
/// green_kitchen app.
void main() {
  const urbanist = 'packages/green_kitchen_ui/Urbanist';

  group('Urbanist font', () {
    test('typography resolves to the bundled package font', () {
      expect(AppTypography.body().fontFamily, urbanist);
      expect(AppTypography.h4().fontFamily, urbanist);
      expect(AppTypography.xSmall().fontFamily, urbanist);
    });

    test('theme text styles keep the bundled font', () {
      for (final theme in [AppTheme.light, AppTheme.dark]) {
        expect(theme.textTheme.bodyLarge?.fontFamily, urbanist);
        expect(theme.textTheme.labelLarge?.fontFamily, urbanist);
        expect(theme.textTheme.headlineMedium?.fontFamily, urbanist);
      }
    });
  });

  test('theme progress indicators are visible on light surfaces', () {
    expect(AppTheme.light.progressIndicatorTheme.color, AppColors.brand);
  });

  group('AppBottomSheet', () {
    Future<void> openSheet(WidgetTester tester, {required bool showHandle}) {
      return tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => AppBottomSheet.show<void>(
                  context: context,
                  showHandle: showHandle,
                  child: const Text('sheet body'),
                ),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      );
    }

    final materialHandle = find.byWidgetPredicate(
      (w) => w.runtimeType.toString() == '_DragHandle',
    );

    testWidgets('does not add the theme drag handle', (tester) async {
      await openSheet(tester, showHandle: true);
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      expect(find.text('sheet body'), findsOneWidget);
      expect(materialHandle, findsNothing);
    });

    testWidgets('showHandle: false shows no handle at all', (tester) async {
      await openSheet(tester, showHandle: false);
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      expect(materialHandle, findsNothing);
    });
  });

  group('AppDropdown', () {
    const items = [
      AppDropdownItem(value: 1, label: 'One'),
      AppDropdownItem(value: 2, label: 'Two'),
    ];

    testWidgets('disposing while open does not throw', (tester) async {
      var show = true;
      late StateSetter setOuter;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                setOuter = setState;
                return show
                    ? AppDropdown<int>(items: items, onChanged: (_) {})
                    : const SizedBox();
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Select'));
      await tester.pump();
      expect(find.text('One'), findsOneWidget);

      setOuter(() => show = false);
      await tester.pump();
      expect(tester.takeException(), isNull);

      // Overlay removal during a build is applied on the following frame.
      await tester.pump();
      expect(find.text('One'), findsNothing);
    });

    testWidgets('selecting an item reports it and closes the menu',
        (tester) async {
      int? picked;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: AppDropdown<int>(
              items: items,
              onChanged: (v) => picked = v,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Select'));
      await tester.pump();
      await tester.tap(find.text('Two'));
      await tester.pump();

      expect(picked, 2);
      expect(find.text('One'), findsNothing);
    });
  });

  group('AppButton disabled state', () {
    Color? labelColor(WidgetTester tester, String label) =>
        tester.widget<Text>(find.text(label)).style?.color;

    testWidgets('non-primary variants fade their label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(
            body: Column(
              children: [
                AppButton(label: 'outline', variant: AppButtonVariant.outline),
                AppButton(label: 'text', variant: AppButtonVariant.text),
              ],
            ),
          ),
        ),
      );

      expect(labelColor(tester, 'outline')?.a, closeTo(0.4, 0.01));
      expect(labelColor(tester, 'text')?.a, closeTo(0.4, 0.01));
    });

    testWidgets('enabled variants keep full label color', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: AppButton(
              label: 'outline',
              variant: AppButtonVariant.outline,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(labelColor(tester, 'outline'), AppColors.brand);
    });
  });

  testWidgets('AppRadioGroup spaces identical items', (tester) async {
    const item = AppRadioGroupItem(value: 1, label: 'Same');
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: AppRadioGroup<int>(
            items: const [item, item, item],
            onChanged: (_) {},
          ),
        ),
      ),
    );

    final spacers = find.descendant(
      of: find.byType(AppRadioGroup<int>),
      matching: find.byWidgetPredicate(
        (w) => w is SizedBox && w.height == AppSpacing.gap16,
      ),
    );
    expect(spacers, findsNWidgets(2));
  });
}
