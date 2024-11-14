import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:member_easy/app/middlewares/auth_middleware.dart';
import 'package:member_easy/injection.dart';
import 'package:member_easy/src/auth/application/auth_service.dart';
import 'package:member_easy/ui/pages/home/bloc/home_cubit.dart';
import 'package:member_easy/ui/pages/home/home_page.dart';
import 'package:member_easy/ui/pages/sign_in/bloc/sign_in_cubit.dart';
import 'package:member_easy/ui/pages/sign_in/sign_in_page.dart';
import 'package:member_easy/ui/pages/splash/bloc/splash_cubit.dart';
import 'package:member_easy/ui/pages/splash/splash_page.dart';
import 'package:member_easy/ui/routes/route_name.dart';

class RoutePage {
  const RoutePage({
    required this.authMiddleware,
  });

  final AuthMiddleware authMiddleware;

  GoRouter get router {
    return GoRouter(
      initialLocation: RouteName.splash,
      redirect: (context, state) {
        if (!authMiddleware.loggedIn) {
          if (state.matchedLocation == RouteName.signIn ||
              state.matchedLocation == RouteName.splash) {
            return null;
          }
          return RouteName.signIn;
        }
        return null;
      },
      refreshListenable: authMiddleware,
      routes: [
        GoRoute(
          path: RouteName.home,
          builder: (context, state) => BlocProvider(
            create: (context) => HomeCubit(),
            child: const HomePage(),
          ),
        ),
        GoRoute(
          path: RouteName.signIn,
          builder: (context, state) => BlocProvider(
            create: (context) => SignInCubit(
              authService: getIt<AuthService>(),
            ),
            child: const SignInPage(),
          ),
        ),
        GoRoute(
          path: RouteName.splash,
          builder: (context, state) => BlocProvider(
            create: (context) => SplashCubit(
              authService: getIt<AuthService>(),
            ),
            child: const SplashPage(),
          ),
        ),
      ],
    );
  }
}
