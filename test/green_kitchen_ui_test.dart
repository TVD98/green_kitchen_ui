import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_kitchen_ui/green_kitchen_ui.dart';

void main() {
  group('AppColors', () {
    test('brand matches kitchen green', () {
      expect(AppColors.primary, const Color(0xFF4AAF57));
      expect(AppColors.brand, AppColors.primary);
      expect(AppColors.accentGreen, AppColors.brand);
      expect(AppColors.lightSoftBrand, const Color(0xFFF0FAF1));
      expect(AppColors.absoluteWhite, const Color(0xFFFFFFFF));
    });
  });

  group('AppTheme', () {
    test('light and dark use brand primary', () {
      expect(AppTheme.light.colorScheme.primary, AppColors.brand);
      expect(AppTheme.dark.colorScheme.primary, AppColors.brand);
    });

    test('dark theme uses dark background', () {
      expect(AppTheme.dark.scaffoldBackgroundColor, AppColors.darkBackground);
    });
  });

  group('tokens', () {
    test('spacing and radius', () {
      expect(AppSpacing.gap10, 10);
      expect(AppSpacing.md, 16);
      expect(AppRadius.tab, 6);
      expect(AppRadius.md, 10);
      expect(AppRadius.lg, 16);
      expect(AppRadius.pill, 1000);
    });

    test('H4 typography size', () {
      expect(AppTypography.h4().fontSize, 24);
      expect(AppTypography.fontFamily, 'Urbanist');
    });
  });

  group('widgets', () {
    testWidgets('AppButton primary renders label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: AppButton(label: 'Sign up', onPressed: () {}),
          ),
        ),
      );

      expect(find.text('Sign up'), findsOneWidget);
    });

    testWidgets('AppTabs reports onChanged', (tester) async {
      var index = 0;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return AppTabs(
                  tabs: const ['Active', 'Completed'],
                  selectedIndex: index,
                  onChanged: (i) => setState(() => index = i),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Completed'));
      await tester.pump();
      expect(index, 1);
    });

    testWidgets('AppLoading defaults to brand and honours color',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                AppLoading(key: Key('default')),
                AppLoading(
                  key: Key('white'),
                  color: AppColors.absoluteWhite,
                ),
              ],
            ),
          ),
        ),
      );

      Color? colorOf(String key) => tester
          .widget<CircularProgressIndicator>(
            find.descendant(
              of: find.byKey(Key(key)),
              matching: find.byType(CircularProgressIndicator),
            ),
          )
          .color;

      expect(colorOf('default'), AppColors.brand);
      expect(colorOf('white'), AppColors.absoluteWhite);
    });

    testWidgets('AppPageIndicator renders markers', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppPageIndicator(count: 3, index: 1),
          ),
        ),
      );

      expect(find.byType(AppPageIndicator), findsOneWidget);
    });

    testWidgets('AppSwitch toggles', (tester) async {
      var value = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return AppSwitch(
                  value: value,
                  onChanged: (v) => setState(() => value = v),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(value, isTrue);
    });
  });
}
