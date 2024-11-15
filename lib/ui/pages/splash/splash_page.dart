import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:member_easy/app/asset/lottie_asset.dart';
import 'package:member_easy/ui/pages/splash/bloc/splash_cubit.dart';
import 'package:member_easy/ui/pages/splash/bloc/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.nextRoute.isEmpty) return;
        context.go(state.nextRoute);
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Lottie.asset(
              LottieAsset.loading.name,
              width: 150.0,
            ),
          ),
        ),
      ),
    );
  }
}
