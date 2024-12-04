import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerDialog extends StatelessWidget {
  const QRScannerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 320.0,
                maxWidth: 320.0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: MobileScanner(
                  onDetect: (barcodeCapture) {
                    context.pop(barcodeCapture.barcodes.first.rawValue);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
