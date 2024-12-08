import 'package:flutter/material.dart';
import 'package:member_easy/app/enum/loading_type_enum.dart';
import 'package:member_easy/ui/theme/color_theme_extension.dart';
import 'package:member_easy/ui/theme/custom_colors.dart';
import 'package:shimmer/shimmer.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.isLoading = true,
    required this.child,
    this.loadingType,
  });

  final Widget child;
  final bool isLoading;
  final LoadingTypeEnum? loadingType;

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return child;
    }
    final Widget selectedChild = loadingType == null
        ? child
        : switch (loadingType!) {
            LoadingTypeEnum.textField => const _LoadingTextField(),
          };
    return Shimmer.fromColors(
      baseColor: Theme.of(context)
              .extension<ColorThemeExtension>()
              ?.shimmerBaseColor ??
          CustomColors.platinum,
      highlightColor: Theme.of(context)
              .extension<ColorThemeExtension>()
              ?.shimmerHighlightColor ??
          CustomColors.whiteSmoke,
      child: selectedChild,
    );
  }
}

class _LoadingTextField extends StatelessWidget {
  const _LoadingTextField();

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.zero,
      elevation: 0.0,
      color: Colors.red,
      child: TextField(
        readOnly: true,
      ),
    );
  }
}
