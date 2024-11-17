import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:member_easy/src/membership/domain/i_membership_repository.dart';
import 'package:member_easy/src/membership/domain/membership.dart';
import 'package:member_easy/src/membership/infrastructure/membership_mapper.dart';

class FirebaseMembershipRepository implements IMembershipRepository {
  const FirebaseMembershipRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<List<Membership>> findByCompanyCode(String companyCode) async {
    final QuerySnapshot<Map<String, dynamic>> response = await _firestore
        .collection('companies')
        .doc(companyCode)
        .collection('memberships')
        .get();
    return response.docs.map(
      (document) {
        return MembershipMapper.fromFirestore(document);
      },
    ).toList();
  }
}
