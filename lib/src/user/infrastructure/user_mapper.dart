import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:member_easy/src/user/domain/user.dart';

class UserMapper {
  const UserMapper._();

  static User fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final Map<String, dynamic> data = document.data();
    return User(
      code: document.id,
      displayName: data['displayName'] as String?,
      email: data['email'] as String?,
      emailVerified: data['emailVerified'] as bool,
      isAnonymous: data['isAnonymous'] as bool,
      phoneNumber: data['phoneNumber'] as String?,
      photoURL: data['photoURL'] as String?,
      refreshToken: data['refreshToken'] as String?,
      tenantId: data['tenantId'] as String?,
    );
  }

  static User fromFirestoreDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final Map<String, dynamic> data = document.data()!;
    return User(
      code: document.id,
      displayName: data['displayName'] as String?,
      email: data['email'] as String?,
      emailVerified: data['emailVerified'] as bool,
      isAnonymous: data['isAnonymous'] as bool,
      phoneNumber: data['phoneNumber'] as String?,
      photoURL: data['photoURL'] as String?,
      refreshToken: data['refreshToken'] as String?,
      tenantId: data['tenantId'] as String?,
    );
  }

  static User fromJson(Map<String, dynamic> map) {
    return User(
      code: map['code'] as String,
      displayName: map['displayName'] as String?,
      email: map['email'] as String?,
      emailVerified: map['emailVerified'] as bool,
      isAnonymous: map['isAnonymous'] as bool,
      phoneNumber: map['phoneNumber'] as String?,
      photoURL: map['photoURL'] as String?,
      refreshToken: map['refreshToken'] as String?,
      tenantId: map['tenantId'] as String?,
    );
  }

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
