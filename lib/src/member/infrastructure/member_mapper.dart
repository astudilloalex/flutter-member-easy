import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:member_easy/src/member/domain/member.dart';
import 'package:member_easy/src/user/infrastructure/user_mapper.dart';

class MemberMapper {
  const MemberMapper._();

  static Member fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final Map<String, dynamic> data = document.data();
    return Member(
      birthdate: data['birthdate'] == null
          ? null
          : DateTime.tryParse(
              data['birthdate'].toString(),
            ),
      code: document.id,
      firstName: data['firstName'] as String,
      idCard: data['idCard'] as String,
      isActive: data['isActive'] as bool,
      joinedAt: DateTime.parse(data['joinedAt'].toString()),
      lastName: data['lastName'] as String,
      user: data['user'] == null
          ? null
          : UserMapper.fromJson(data['user'] as Map<String, dynamic>),
    );
  }

  static Member fromFirestoreDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final Map<String, dynamic> data = document.data()!;
    return Member(
      birthdate: data['birthdate'] == null
          ? null
          : DateTime.tryParse(
              data['birthdate'].toString(),
            ),
      code: document.id,
      firstName: data['firstName'] as String,
      idCard: data['idCard'] as String,
      isActive: data['isActive'] as bool,
      joinedAt: DateTime.parse(data['joinedAt'].toString()),
      lastName: data['lastName'] as String,
      user: data['user'] == null
          ? null
          : UserMapper.fromJson(data['user'] as Map<String, dynamic>),
    );
  }

  static Map<String, dynamic> toJson(Member member) {
    return {
      'code': member.code,
      'birthdate': member.birthdate?.toIso8601String(),
      'firstName': member.firstName,
      'fullName': member.fullName,
      'idCard': member.idCard,
      'isActive': member.isActive,
      'joinedAt': member.joinedAt.toIso8601String(),
      'lastName': member.lastName,
      'user': member.user == null ? null : UserMapper.toJson(member.user!),
    };
  }
}
