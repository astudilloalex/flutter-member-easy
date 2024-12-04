import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/src/auth/domain/i_auth_repository.dart';
import 'package:member_easy/src/user/domain/user.dart';

class FirebaseAuthRepository implements IAuthRepository {
  const FirebaseAuthRepository(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user == null) {
      return const Left(FirebaseFailure(failureEnum: FailureEnum.userNotFound));
    }
    return Right(
      User(
        code: userCredential.user!.uid,
        displayName: userCredential.user!.displayName,
        email: userCredential.user!.email,
        emailVerified: userCredential.user!.emailVerified,
        isAnonymous: userCredential.user!.isAnonymous,
        phoneNumber: userCredential.user!.phoneNumber,
        photoURL: userCredential.user!.photoURL,
        refreshToken: userCredential.user!.refreshToken,
        tenantId: userCredential.user!.tenantId,
      ),
    );
  }

  @override
  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges().map(
      (user) {
        if (user == null) return null;
        return User(
          code: user.uid,
          displayName: user.displayName,
          email: user.email,
          emailVerified: user.emailVerified,
          isAnonymous: user.isAnonymous,
          phoneNumber: user.phoneNumber,
          photoURL: user.photoURL,
          refreshToken: user.refreshToken,
          tenantId: user.tenantId,
        );
      },
    );
  }

  @override
  Future<User?> get currentUser async {
    if (_firebaseAuth.currentUser == null) return null;
    return User(
      code: _firebaseAuth.currentUser!.uid,
      displayName: _firebaseAuth.currentUser!.displayName,
      email: _firebaseAuth.currentUser!.email,
      emailVerified: _firebaseAuth.currentUser!.emailVerified,
      isAnonymous: _firebaseAuth.currentUser!.isAnonymous,
      phoneNumber: _firebaseAuth.currentUser!.phoneNumber,
      photoURL: _firebaseAuth.currentUser!.photoURL,
      refreshToken: _firebaseAuth.currentUser!.refreshToken,
      tenantId: _firebaseAuth.currentUser!.tenantId,
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user == null) {
      return const Left(
        FirebaseFailure(
          failureEnum: FailureEnum.failedToCreateUser,
        ),
      );
    }
    return Right(
      User(
        code: userCredential.user!.uid,
        displayName: userCredential.user!.displayName,
        email: userCredential.user!.email,
        emailVerified: userCredential.user!.emailVerified,
        isAnonymous: userCredential.user!.isAnonymous,
        phoneNumber: userCredential.user!.phoneNumber,
        photoURL: userCredential.user!.photoURL,
        refreshToken: userCredential.user!.refreshToken,
        tenantId: userCredential.user!.tenantId,
      ),
    );
  }

  @override
  Future<void> signOut() async {
    if (_firebaseAuth.currentUser == null) return;
    final List<UserInfo> userInfo = _firebaseAuth.currentUser!.providerData;
    if (userInfo.any(
      (element) => element.providerId == 'google.com',
    )) {
      await GoogleSignIn().signOut();
    }
    await _firebaseAuth.signOut();
  }

  @override
  Future<Either<Failure, User>> signInWithGoogle(
    OAuthCredential? oAuthCredential,
    AuthProvider? authProvider, {
    bool isWeb = false,
  }) async {
    assert(oAuthCredential != null || authProvider != null);
    final UserCredential userCredential = oAuthCredential != null
        ? await _firebaseAuth.signInWithCredential(
            oAuthCredential,
          )
        : await _firebaseAuth.signInWithPopup(authProvider!);
    if (userCredential.user == null) {
      return const Left(FirebaseFailure(failureEnum: FailureEnum.userNotFound));
    }
    return Right(
      User(
        code: userCredential.user!.uid,
        displayName: userCredential.user!.displayName,
        email: userCredential.user!.email,
        emailVerified: userCredential.user!.emailVerified,
        isAnonymous: userCredential.user!.isAnonymous,
        phoneNumber: userCredential.user!.phoneNumber,
        photoURL: userCredential.user!.photoURL,
        refreshToken: userCredential.user!.refreshToken,
        tenantId: userCredential.user!.tenantId,
      ),
    );
  }
}
