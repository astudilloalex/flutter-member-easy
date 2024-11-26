import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:member_easy/ui/pages/sign_in/bloc/sign_in_cubit.dart';
import 'package:member_easy/ui/pages/sign_in/bloc/sign_in_state.dart';
import 'package:member_easy/ui/widgets/loading_indicator.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignInCubit, SignInState, bool>(
      selector: (state) => state.isLoading,
      builder: (context, isLoading) {
        return LoadingIndicator(
          isLoading: isLoading,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.login_outlined),
            label: Text(
              AppLocalizations.of(context)!.signIn,
            ),
            onPressed: isLoading
                ? () {}
                : () {
                    context.read<SignInCubit>().signInWithEmailAndPassword();
                  },
          ),
        );
      },
    );
  }
}
