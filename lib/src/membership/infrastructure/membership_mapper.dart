import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:member_easy/src/membership/domain/membership.dart';

class MembershipMapper {
  const MembershipMapper._();

  static Membership fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final Map<String, dynamic> json = document.data();
    return Membership(
      code: json['code'] as String,
      id: json['id'] as int,
      name: json['name'] as String,
      cost: double.parse(json['cost'].toString()),
    );
  }
}
