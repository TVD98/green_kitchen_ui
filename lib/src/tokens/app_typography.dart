import 'package:flutter/material.dart';

/// Typography scale using Urbanist, bundled with this package.
enum AppTextVariant {
  display,
  headline,
  h4,
  title,
  body,
  label,
  caption,
  xSmall,
}

abstract final class AppTypography {
  static const String fontFamily = 'Urbanist';

  /// Package that bundles [fontFamily]; consumers resolve the font through it.
  static const String fontPackage = 'green_kitchen_ui';

  static const double _headingHeight = 1.4;
  static const double _bodyHeight = 1.6;
  static const double _bodyLetterSpacing = 0.2;

  static TextStyle _heading(double fontSize, Color? color) => TextStyle(
        fontFamily: fontFamily,
        package: fontPackage,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        height: _headingHeight,
        letterSpacing: 0,
        color: color,
      );

  static TextStyle _text(double fontSize, FontWeight weight, Color? color) =>
      TextStyle(
        fontFamily: fontFamily,
        package: fontPackage,
        fontSize: fontSize,
        fontWeight: weight,
        height: _bodyHeight,
        letterSpacing: _bodyLetterSpacing,
        color: color,
      );

  static TextStyle display({Color? color}) => _heading(32, color);

  static TextStyle headline({Color? color}) => _heading(28, color);

  /// H4 — navigation titles (24 bold / LH 1.4).
  static TextStyle h4({Color? color}) => _heading(24, color);

  static TextStyle title({Color? color}) => _heading(20, color);

  static TextStyle h6({Color? color}) => _heading(18, color);

  static TextStyle body({Color? color, FontWeight weight = FontWeight.normal}) =>
      _text(16, weight, color);

  static TextStyle label({Color? color}) =>
      _text(14, FontWeight.w500, color);

  static TextStyle caption({Color? color}) =>
      _text(12, FontWeight.normal, color);

  static TextStyle xSmall({Color? color}) =>
      _text(10, FontWeight.w500, color);

  static TextStyle forVariant(AppTextVariant variant, {Color? color}) {
    return switch (variant) {
      AppTextVariant.display => display(color: color),
      AppTextVariant.headline => headline(color: color),
      AppTextVariant.h4 => h4(color: color),
      AppTextVariant.title => title(color: color),
      AppTextVariant.body => body(color: color),
      AppTextVariant.label => label(color: color),
      AppTextVariant.caption => caption(color: color),
      AppTextVariant.xSmall => xSmall(color: color),
    };
  }

  static TextTheme textTheme([TextTheme? base]) {
    final seed = base ?? ThemeData.light().textTheme;
    return seed.copyWith(
      displayLarge: display(),
      displayMedium: display(),
      displaySmall: headline(),
      headlineLarge: headline(),
      headlineMedium: h4(),
      headlineSmall: title(),
      titleLarge: title(),
      titleMedium: h6(),
      titleSmall: label(),
      bodyLarge: body(),
      bodyMedium: body(),
      bodySmall: caption(),
      labelLarge: label(),
      labelMedium: label(),
      labelSmall: xSmall(),
    );
  }
}
