import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:member_easy/ui/pages/sign_up/bloc/sign_up_cubit.dart';
import 'package:member_easy/ui/pages/sign_up/bloc/sign_up_state.dart';
import 'package:member_easy/ui/widgets/loading_indicator.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignUpCubit, SignUpState, bool>(
      selector: (state) => state.isLoading,
      builder: (context, isLoading) {
        return LoadingIndicator(
          isLoading: isLoading,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.login_outlined),
            label: Text(
              AppLocalizations.of(context)!.signUp,
            ),
            onPressed: isLoading
                ? () {}
                : () {
                    context.read<SignUpCubit>().signUp();
                  },
          ),
        );
      },
    );
  }
}
