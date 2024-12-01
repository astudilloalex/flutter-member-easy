import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    this.mainActionText,
    this.message = '',
    this.onMainAction,
  });

  final String? mainActionText;
  final String message;
  final VoidCallback? onMainAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.error_outline, size: 80, color: Colors.red),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                message,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            if (onMainAction != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: onMainAction,
                    child: Text(
                      mainActionText ?? AppLocalizations.of(context)!.retry,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
