import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:member_easy/app/asset/lottie_asset.dart';
import 'package:member_easy/app/bloc/app_cubit.dart';
import 'package:member_easy/app/core/app_session_data.dart';
import 'package:member_easy/ui/pages/splash/bloc/splash_cubit.dart';
import 'package:member_easy/ui/pages/splash/bloc/splash_state.dart';
import 'package:member_easy/ui/widgets/custom_error_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.nextRoute.isEmpty) return;
        context.read<AppCubit>().updateCompanies(state.companies);
        AppSessionData.company = state.companies.firstOrNull;
        context.go(state.nextRoute);
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocSelector<SplashCubit, SplashState, String>(
            selector: (state) {
              return state.error;
            },
            builder: (context, error) {
              if (error.isNotEmpty) {
                return CustomErrorWidget(
                  message: error,
                  onMainAction: () {
                    context.read<SplashCubit>().init();
                  },
                );
              }
              return Center(
                child: Lottie.asset(
                  LottieAsset.loading.name,
                  width: 150.0,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
