import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:member_easy/ui/pages/sign_up/bloc/sign_up_cubit.dart';
import 'package:member_easy/ui/pages/sign_up/bloc/sign_up_state.dart';
import 'package:member_easy/ui/pages/sign_up/widgets/sign_up_button.dart';
import 'package:member_easy/ui/pages/sign_up/widgets/sign_up_form.dart';
import 'package:member_easy/ui/pages/sign_up/widgets/sign_up_google_button.dart';
import 'package:member_easy/ui/routes/route_name.dart';
import 'package:member_easy/ui/theme/color_theme_extension.dart';
import 'package:member_easy/ui/utils/banner_util.dart';
import 'package:member_easy/ui/utils/error_code_mapper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  BlocListener<SignUpCubit, SignUpState>(
                    listener: (context, state) {
                      if (state.error.isNotEmpty) {
                        BannerUtil.showErrorMaterialBanner(
                          message: ErrorCodeMapper.errorCodeToMessage(
                            state.error,
                            context: context,
                          ),
                          context: context,
                        );
                        return;
                      }
                      if (state.nextRoute.isNotEmpty) {
                        context.go(state.nextRoute);
                        return;
                      }
                    },
                    child: const SignUpForm(),
                  ),
                  SliverList.list(
                    children: [
                      const SizedBox(height: 16.0),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: SignUpButton(),
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
                        child: SignUpGoogleButton(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Text.rich(
              TextSpan(
                text: '${AppLocalizations.of(context)!.alreadyHaveAnAccount} ',
                children: [
                  WidgetSpan(
                    child: InkWell(
                      onTap: () {
                        context.go(RouteName.signIn);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.signIn,
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
    );
  }
}
