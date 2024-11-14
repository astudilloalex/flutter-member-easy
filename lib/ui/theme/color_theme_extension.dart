import 'package:flutter/material.dart';

class ColorThemeExtension extends ThemeExtension<ColorThemeExtension> {
  const ColorThemeExtension({
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
  });

  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;

  @override
  ThemeExtension<ColorThemeExtension> copyWith({
    Color? shimmerBaseColor,
    Color? shimmerHighlightColor,
  }) {
    return ColorThemeExtension(
      shimmerBaseColor: shimmerBaseColor ?? this.shimmerBaseColor,
      shimmerHighlightColor:
          shimmerHighlightColor ?? this.shimmerHighlightColor,
    );
  }

  @override
  ThemeExtension<ColorThemeExtension> lerp(
    covariant ThemeExtension<ColorThemeExtension>? other,
    double t,
  ) {
    if (other is! ColorThemeExtension) {
      return this;
    }
    return ColorThemeExtension(
      shimmerBaseColor: Color.lerp(
            shimmerBaseColor,
            other.shimmerBaseColor,
            t,
          ) ??
          shimmerBaseColor,
      shimmerHighlightColor: Color.lerp(
            shimmerHighlightColor,
            other.shimmerHighlightColor,
            t,
          ) ??
          shimmerHighlightColor,
    );
  }
}
