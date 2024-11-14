import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:member_easy/ui/pages/sign_in/bloc/sign_in_cubit.dart';
import 'package:member_easy/ui/pages/sign_in/bloc/sign_in_state.dart';
import 'package:member_easy/ui/utils/error_code_mapper.dart';
import 'package:member_easy/ui/widgets/password_text_form_field.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignInCubit>().formKey,
      child: SliverList.list(
        children: [
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocSelector<SignInCubit, SignInState, bool>(
              selector: (state) => state.isLoading,
              builder: (context, isLoading) {
                return TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  readOnly: isLoading,
                  enabled: !isLoading,
                  controller: context.read<SignInCubit>().emailController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.email,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    final String? error =
                        context.read<SignInCubit>().validateEmail(value);
                    if (error == null) return error;
                    return ErrorCodeMapper.errorCodeToMessage(
                      error,
                      context: context,
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocSelector<SignInCubit, SignInState, bool>(
              selector: (state) => state.isLoading,
              builder: (context, isLoading) {
                return PasswordTextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  readOnly: isLoading,
                  enabled: !isLoading,
                  controller: context.read<SignInCubit>().passwordController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.password,
                  ),
                  validator: (value) {
                    final String? error =
                        context.read<SignInCubit>().validatePassword(value);
                    if (error == null) return error;
                    return ErrorCodeMapper.errorCodeToMessage(
                      error,
                      context: context,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
