import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:member_easy/core/firebase/firebase_auth_service.dart';

final GetIt getIt = GetIt.instance;

class Injection {
  const Injection._();

  static Future<void> init() async {
    getIt.registerLazySingleton<FirebaseAuth>(
      () => FirebaseAuth.instance,
    );
    getIt.registerLazySingleton<GoogleSignIn>(
      () => GoogleSignIn(),
    );
    getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );

    getIt.registerLazySingleton<FirebaseAuthService>(
      () => FirebaseAuthService(getIt<FirebaseAuth>()),
    );
  }
}
