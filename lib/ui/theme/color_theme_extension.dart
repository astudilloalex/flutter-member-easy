import 'package:flutter/material.dart';

class ColorThemeExtension extends ThemeExtension<ColorThemeExtension> {
  const ColorThemeExtension({
    this.link,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
  });

  final Color? link;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;

  @override
  ThemeExtension<ColorThemeExtension> copyWith({
    Color? link,
    Color? shimmerBaseColor,
    Color? shimmerHighlightColor,
  }) {
    return ColorThemeExtension(
      link: link ?? this.link,
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
      link: Color.lerp(
            link,
            other.link,
            t,
          ) ??
          link,
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
