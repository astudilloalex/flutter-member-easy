import 'package:go_router/go_router.dart';

class AppRoutes {
  const AppRoutes._();

  static const String home = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String splash = '/splash';
}

class AppRouter {
  const AppRouter();

  GoRouter get router {
    return GoRouter(
      routes: [],
    );
  }
}
