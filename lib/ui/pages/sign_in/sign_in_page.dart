import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:member_easy/ui/pages/sign_in/bloc/sign_in_cubit.dart';
import 'package:member_easy/ui/pages/sign_in/bloc/sign_in_state.dart';
import 'package:member_easy/ui/pages/sign_in/widgets/sign_in_button.dart';
import 'package:member_easy/ui/pages/sign_in/widgets/sign_in_form.dart';
import 'package:member_easy/ui/pages/sign_in/widgets/sign_in_google_button.dart';
import 'package:member_easy/ui/routes/route_name.dart';
import 'package:member_easy/ui/theme/color_theme_extension.dart';
import 'package:member_easy/ui/utils/banner_util.dart';

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
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    const SignInForm(),
                    SliverList.list(
                      children: [
                        const SizedBox(height: 16.0),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: SignInButton(),
                        ),
                        const SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Divider(),
                              ),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!.orContinueWith,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Expanded(
                                child: Divider(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: SignInGoogleButton(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Text.rich(
                TextSpan(
                  text: '${AppLocalizations.of(context)!.doNotHaveAnAccount} ',
                  children: [
                    WidgetSpan(
                      child: InkWell(
                        onTap: () {
                          context.go(RouteName.signUp);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signUp,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context)
                                .extension<ColorThemeExtension>()
                                ?.link,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
