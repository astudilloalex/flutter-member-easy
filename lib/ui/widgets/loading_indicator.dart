import 'package:flutter/material.dart';
import 'package:member_easy/ui/theme/color_theme_extension.dart';
import 'package:member_easy/ui/theme/custom_colors.dart';
import 'package:shimmer/shimmer.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.isLoading = true,
    required this.child,
  });

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return child;
    }
    return Shimmer.fromColors(
      baseColor: Theme.of(context)
              .extension<ColorThemeExtension>()
              ?.shimmerBaseColor ??
          CustomColors.platinum,
      highlightColor: Theme.of(context)
              .extension<ColorThemeExtension>()
              ?.shimmerHighlightColor ??
          CustomColors.whiteSmoke,
      child: child,
    );
  }
}
