import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorCodeMapper {
  const ErrorCodeMapper._();
  static String errorCodeToMessage(
    String code, {
    required BuildContext context,
  }) {
    final Map<String, String> data = {
      'invalid-email': AppLocalizations.of(context)!.invalidEmail,
      'maximum-number-members-reached':
          AppLocalizations.of(context)!.maximumNumberMembersReached,
      'passwords-do-not-match':
          AppLocalizations.of(context)!.passwordsDoNotMatch,
      'weak-password': AppLocalizations.of(context)!.weakPassword,
    };
    return data[code] ?? code;
  }
}
