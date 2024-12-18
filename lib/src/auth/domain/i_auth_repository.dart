import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/src/user/domain/user.dart';

abstract class IAuthRepository {
  const IAuthRepository();

  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signInWithGoogle(
    OAuthCredential? oAuthCredential,
    AuthProvider? authProvider, {
    bool isWeb = false,
  });

  Stream<User?> authStateChanges();

  Future<User?> get currentUser;

  Future<void> signOut();
}
