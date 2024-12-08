import 'package:member_easy/src/user/domain/user.dart';

abstract class IUserRepository {
  const IUserRepository();

  Future<User> saveOrUpdate(User user);

  Future<User?> findByCode(String code);
}
