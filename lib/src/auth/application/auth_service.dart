import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      return Left(FirebaseFailure(message: e.code));
    } catch (e) {
      return const Left(
        FirebaseFailure(
          failureEnum: FailureEnum.anUnknownErrorOcurred,
        ),
      );
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
      return Left(FirebaseFailure(message: e.code));
    } catch (e) {
      return const Left(
        FirebaseFailure(
          failureEnum: FailureEnum.anUnknownErrorOcurred,
        ),
      );
    }
  }

  Future<Either<Failure, bool>> signOut() async {
    try {
      await _repository.signOut();
      return const Right(true);
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, User>> signInWithGoogle({
    bool isWeb = false,
  }) async {
    try {
      // Only if web
      if (isWeb) {
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        final Either<Failure, User> response =
            await _repository.signInWithGoogle(null, googleProvider);
        return await response.fold(
          (failure) {
            return Left(failure);
          },
          (user) async {
            await userRepository.saveOrUpdate(user);
            return Right(user);
          },
        );
      }
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final Either<Failure, User> response =
          await _repository.signInWithGoogle(credential, null);
      return await response.fold(
        (failure) {
          return Left(failure);
        },
        (user) async {
          await userRepository.saveOrUpdate(user);
          return Right(user);
        },
      );
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }
}
