import 'package:flutter/material.dart';
import 'package:member_easy/ui/theme/color_theme_extension.dart';
import 'package:member_easy/ui/theme/custom_colors.dart';

class AppThemeData {
  const AppThemeData._();

  static ThemeData get light {
    const ColorThemeExtension colorThemeExtension = ColorThemeExtension(
      link: CustomColors.dodgerBlue,
      shimmerBaseColor: CustomColors.platinum,
      shimmerHighlightColor: CustomColors.whiteSmoke,
    );
    return ThemeData.light().copyWith(
      extensions: [colorThemeExtension],
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
