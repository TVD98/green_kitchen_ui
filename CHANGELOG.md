## 0.1.0

First release as a standalone package (split out of the `green_kitchen` app,
history preserved).

### Fixed

* **Urbanist now actually renders.** The font is bundled in `fonts/` and every
  style uses `fontFamily: 'Urbanist', package: 'green_kitchen_ui'`. Previously
  the theme replaced the `google_fonts` styles with a plain `'Urbanist'` family
  that was never loaded, so apps fell back to the system font.
* `AppLoading` and the theme's `progressIndicatorTheme` default to the brand
  color instead of white, which was invisible on light surfaces. Pass
  `color: AppColors.absoluteWhite` for brand or image backgrounds.
* `AppBottomSheet` no longer shows the theme's Material drag handle on top of
  its own handle.
* `AppDropdown` no longer throws when it is disposed while its menu is open,
  and an open menu now updates when `items` change.
* Disabled `AppButton` outline, text, soft and social variants now fade their
  label (and the outline border) instead of looking enabled.
* `AppRadioGroup` spaces items by index, so identical items are separated too.

### Changed

* Removed the `google_fonts` dependency (no runtime font download, works
  offline and in tests).
* `AppLoading` has a new optional `color` parameter.
* Added an `example/` widget gallery and regression tests.

## 0.0.1

* Initial version inside the `green_kitchen` app (`packages/green_kitchen_ui`).
