import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:member_easy/app/middlewares/auth_middleware.dart';
import 'package:member_easy/firebase_options.dart';
import 'package:member_easy/injection.dart';
import 'package:member_easy/ui/routes/route_page.dart';
import 'package:member_easy/ui/theme/app_theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _init();
  runApp(
    MyApp(
      router: RoutePage(
        authMiddleware: getIt<AuthMiddleware>(),
      ).router,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.router,
  });

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: router,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppThemeData.light,
    );
  }
}

Future<void> _init() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currenPlatform,
  );
  if (kIsWeb) {
    await FirebaseAuth.instance.setPersistence(Persistence.SESSION);
  }
  Injection.init();
}
