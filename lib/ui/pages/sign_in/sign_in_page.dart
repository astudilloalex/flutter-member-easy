import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:member_easy/ui/pages/sign_in/bloc/sign_in_cubit.dart';
import 'package:member_easy/ui/pages/sign_in/bloc/sign_in_state.dart';
import 'package:member_easy/ui/pages/sign_in/widgets/sign_in_form.dart';
import 'package:member_easy/ui/utils/banner_util.dart';
import 'package:member_easy/ui/widgets/loading_indicator.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<SignInCubit, SignInState>(
          listenWhen: (previous, current) =>
              previous.error != current.error ||
              previous.nextRoute != current.nextRoute,
          listener: (context, state) {
            if (state.error.isNotEmpty) {
              BannerUtil.showErrorMaterialBanner(
                message: state.error,
                context: context,
              );
              return;
            }
            if (state.nextRoute.isNotEmpty) {
              context.go(state.nextRoute);
            }
          },
          child: CustomScrollView(
            slivers: [
              const SignInForm(),
              SliverList.list(
                children: [
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: BlocSelector<SignInCubit, SignInState, bool>(
                      selector: (state) => state.isLoading,
                      builder: (context, isLoading) {
                        return LoadingIndicator(
                          isLoading: isLoading,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? () {}
                                : () {
                                    context
                                        .read<SignInCubit>()
                                        .signInWithEmailAndPassword();
                                  },
                            child: Text(AppLocalizations.of(context)!.signIn),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
