# green_kitchen_ui

Green Kitchen design system for Flutter: color, typography, spacing and radius
tokens, light/dark `ThemeData`, and 18 base widgets. Urbanist is bundled, so
there is no runtime font download.

## Install

The package is not on pub.dev. Add it as a git or path dependency.

From git (after this repo is pushed to GitHub):

```yaml
dependencies:
  green_kitchen_ui:
    git:
      url: https://github.com/TVD98/green_kitchen_ui.git
      ref: v0.1.0 # a tag or commit, so builds are reproducible
```

From a local checkout:

```yaml
dependencies:
  green_kitchen_ui:
    path: ../green_kitchen_ui
```

Then run `flutter pub get`. Requires Dart `^3.12.2`.

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:green_kitchen_ui/green_kitchen_ui.dart';

void main() => runApp(
      MaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: Scaffold(
          appBar: const AppNavigationHeader(title: 'Recipes', showBack: false),
          body: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                const AppText('Hello', variant: AppTextVariant.headline),
                const SizedBox(height: AppSpacing.md),
                AppButton(label: 'Get started', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
```

Use the tokens instead of raw values so apps stay consistent:
`AppColors.brand`, `AppTypography.body()`, `AppSpacing.md`, `AppRadius.card`.

## What's inside

| Group | API |
|---|---|
| Tokens | `AppColors`, `AppTypography` + `AppTextVariant`, `AppSpacing`, `AppRadius` |
| Theme | `AppTheme.light`, `AppTheme.dark` |
| Actions | `AppButton` (primary, soft, outline, social, text; loading and disabled states), `AppLinkText` |
| Inputs | `AppTextField`, `AppDropdown`, `AppCheckbox`, `AppRadio`, `AppRadioGroup`, `AppSwitch`, `AppSlider` |
| Selection | `AppTabs`, `AppChips`, `AppSelectionList`, `AppPageIndicator` |
| Surfaces | `AppCard`, `AppDialog.show`, `AppBottomSheet.show`, `AppNavigationHeader`, `AppLoading`, `AppText` |

All selection widgets are controlled: they report changes through `onChanged`
and render whatever value you pass back.

`AppLoading` is brand green by default. On a brand or image background, pass
`color: AppColors.absoluteWhite`.

## Example

`example/` is a widget gallery with a light/dark toggle:

```bash
cd example
flutter run
```

## Development

```bash
flutter analyze
flutter test
```

`test/regression_test.dart` covers the bugs fixed in 0.1.0 (see
`CHANGELOG.md`).

## Fonts

Urbanist (Regular, Medium, SemiBold, Bold) is licensed under the SIL Open Font
License 1.1. See `fonts/OFL.txt`.
