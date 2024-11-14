import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:member_easy/app/middlewares/auth_middleware.dart';
import 'package:member_easy/src/auth/application/auth_service.dart';
import 'package:member_easy/src/auth/domain/i_auth_repository.dart';
import 'package:member_easy/src/auth/infrastructure/firebase_auth_repository.dart';

final GetIt getIt = GetIt.instance;

class Injection {
  const Injection._();

  static void init() {
    // Declare repositories
    getIt.registerLazySingleton<IAuthRepository>(
      () => FirebaseAuthRepository(FirebaseAuth.instance),
    );

    // Declare services
    getIt.registerFactory<AuthService>(
      () => AuthService(getIt<IAuthRepository>()),
    );

    // Declare middlewares
    getIt.registerFactory<AuthMiddleware>(
      () => AuthMiddleware(getIt<AuthService>()),
    );
  }
}
