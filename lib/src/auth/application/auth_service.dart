import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/src/auth/domain/i_auth_repository.dart';
import 'package:member_easy/src/user/domain/user.dart';

class AuthService {
  const AuthService(this._repository);

  final IAuthRepository _repository;

  Stream<User?> authStateChanges() {
    return _repository.authStateChanges();
  }

  Future<User?> get currentUser async {
    try {
      return _repository.currentUser;
    } catch (e) {
      return null;
    }
  }

  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _repository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure(e.code));
    } catch (e) {
      return const Left(FirebaseFailure('an-unknown-error-ocurred'));
    }
  }
}
