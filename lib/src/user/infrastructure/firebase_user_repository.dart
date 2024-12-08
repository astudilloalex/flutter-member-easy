import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:member_easy/src/user/domain/i_user_repository.dart';
import 'package:member_easy/src/user/domain/user.dart';
import 'package:member_easy/src/user/infrastructure/user_mapper.dart';

class FirebaseUserRepository implements IUserRepository {
  const FirebaseUserRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<User> saveOrUpdate(User user) async {
    await _firestore
        .collection('users')
        .doc(user.code)
        .set(UserMapper.toJson(user));
    return user;
  }

  @override
  Future<User?> findByCode(String code) async {
    final DocumentSnapshot<Map<String, dynamic>> document =
        await _firestore.collection('users').doc(code).get();

    if (!document.exists) return null;
    return UserMapper.fromFirestoreDocument(document);
  }
}
