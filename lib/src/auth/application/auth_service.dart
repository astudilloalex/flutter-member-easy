import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/src/auth/domain/i_auth_repository.dart';
import 'package:member_easy/src/user/domain/i_user_repository.dart';
import 'package:member_easy/src/user/domain/user.dart';

class AuthService {
  const AuthService(
    this._repository, {
    required this.userRepository,
  });

  final IAuthRepository _repository;
  final IUserRepository userRepository;

  Stream<User?> authStateChanges() {
    return _repository.authStateChanges();
  }

  Future<User?> get currentUser async {
    try {
      return await _repository.currentUser;
    } catch (e) {
      return null;
    }
  }

  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final Either<Failure, User> response =
          await _repository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await response.fold(
        (failure) {
          return Left(failure);
        },
        (user) async {
          await userRepository.saveOrUpdate(user);
          return Right(user);
        },
      );
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure(e.code));
    } catch (e) {
      return const Left(FirebaseFailure('an-unknown-error-ocurred'));
    }
  }

  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final Either<Failure, User> response =
          await _repository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await response.fold(
        (failure) {
          return Left(failure);
        },
        (user) async {
          await userRepository.saveOrUpdate(user);
          return Right(user);
        },
      );
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure(e.code));
    } catch (e) {
      return const Left(FirebaseFailure('an-unknown-error-ocurred'));
    }
  }

  Future<Either<Failure, bool>> signOut() async {
    try {
      await _repository.signOut();
      return const Right(true);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }
}
