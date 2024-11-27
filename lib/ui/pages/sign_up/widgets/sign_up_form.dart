import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:member_easy/ui/pages/sign_up/bloc/sign_up_cubit.dart';
import 'package:member_easy/ui/utils/error_code_mapper.dart';
import 'package:member_easy/ui/widgets/password_text_form_field.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignUpCubit>().formKey,
      child: SliverList.list(
        children: [
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: context.read<SignUpCubit>().emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.email,
              ),
              validator: (value) {
                final String? error =
                    context.read<SignUpCubit>().validateEmail(value);
                if (error == null) return error;
                return ErrorCodeMapper.errorCodeToMessage(
                  error,
                  context: context,
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: PasswordTextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: context.read<SignUpCubit>().passwordController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.password,
              ),
              validator: (value) {
                final String? error =
                    context.read<SignUpCubit>().validatePassword(value);
                if (error == null) return error;
                return ErrorCodeMapper.errorCodeToMessage(
                  error,
                  context: context,
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: PasswordTextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: context.read<SignUpCubit>().confirmPasswordController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.confirmPassword,
              ),
              validator: (value) {
                final String? error =
                    context.read<SignUpCubit>().validateConfirmPassword(value);
                if (error == null) return error;
                return ErrorCodeMapper.errorCodeToMessage(
                  error,
                  context: context,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
