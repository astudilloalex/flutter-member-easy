import 'package:member_easy/features/users/domain/entities/user.dart';

abstract class IUserRepository {
  const IUserRepository();

  Future<User> get currentUser;

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}
