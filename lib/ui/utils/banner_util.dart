import 'dart:async';

import 'package:flutter/material.dart';
import 'package:member_easy/ui/utils/error_code_mapper.dart';

class BannerUtil {
  const BannerUtil._();

  static Timer? _hideTimer;

  static void _cancelTimer() {
    _hideTimer?.cancel();
    _hideTimer = null;
  }

  static Future<void> showErrorMaterialBanner({
    required String message,
    required BuildContext context,
    Duration duration = const Duration(milliseconds: 4000),
  }) async {
    if (!context.mounted) return;
    _cancelTimer();

    final ScaffoldMessengerState scaffoldMessenger =
        ScaffoldMessenger.of(context);

    scaffoldMessenger.hideCurrentMaterialBanner();

    scaffoldMessenger.showMaterialBanner(
      MaterialBanner(
        content: Text(
          ErrorCodeMapper.errorCodeToMessage(
            message,
            context: context,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              scaffoldMessenger.hideCurrentMaterialBanner();
              _cancelTimer();
            },
            icon: const Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.circle_outlined,
                  size: 30.0,
                ),
                Icon(Icons.close),
              ],
            ),
          ),
        ],
        leading: const Icon(Icons.error_outline_outlined),
      ),
    );

    _hideTimer = Timer(
      duration,
      () {
        if (!context.mounted) return;
        scaffoldMessenger.hideCurrentMaterialBanner();
        _cancelTimer();
      },
    );
  }
}
