import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  const FirebaseAuthService(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  User? get currentUser => _firebaseAuth.currentUser;
}
