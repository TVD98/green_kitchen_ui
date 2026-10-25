import 'package:flutter/material.dart';

import '../tokens/app_colors.dart';

/// Centered spinning [CircularProgressIndicator], brand-colored by default.
///
/// Pass [color] (e.g. [AppColors.absoluteWhite]) when placing it on a brand or
/// image background.
class AppLoading extends StatelessWidget {
  const AppLoading({
    super.key,
    this.size = 36,
    this.strokeWidth = 3,
    this.color,
  });

  final double size;
  final double strokeWidth;

  /// Defaults to [AppColors.brand].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          color: color ?? AppColors.brand,
        ),
      ),
    );
  }
}
