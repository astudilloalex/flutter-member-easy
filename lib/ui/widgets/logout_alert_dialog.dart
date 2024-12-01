import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:member_easy/app/bloc/app_cubit.dart';
import 'package:member_easy/app/bloc/app_state.dart';
import 'package:member_easy/ui/widgets/loading_indicator.dart';

class LogoutAlertDialog extends StatelessWidget {
  const LogoutAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppCubit, AppState, bool>(
      selector: (state) => state.closingSession,
      builder: (context, closingSession) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.exit,
          ),
          content: Text(
            AppLocalizations.of(context)!.areYouSure,
          ),
          actions: [
            LoadingIndicator(
              isLoading: closingSession,
              child: TextButton(
                onPressed: closingSession
                    ? () {}
                    : () {
                        context.pop();
                      },
                child: Text(AppLocalizations.of(context)!.no),
              ),
            ),
            LoadingIndicator(
              isLoading: closingSession,
              child: TextButton(
                onPressed: closingSession
                    ? () {}
                    : () async {
                        await context.read<AppCubit>().logout();
                        if (!context.mounted) return;
                        context.pop();
                      },
                child: Text(AppLocalizations.of(context)!.yes),
              ),
            ),
          ],
        );
      },
    );
  }
}
