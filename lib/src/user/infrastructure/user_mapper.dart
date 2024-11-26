import 'package:member_easy/src/user/domain/user.dart';

class UserMapper {
  const UserMapper._();

  static Map<String, dynamic> toJson(User user) {
    return {
      'code': user.code,
      'displayName': user.displayName,
      'email': user.email,
      'emailVerified': user.emailVerified,
      'isAnonymous': user.isAnonymous,
      'phoneNumber': user.phoneNumber,
      'photoURL': user.photoURL,
      'refreshToken': user.refreshToken,
      'tenantId': user.tenantId,
    };
  }
}
