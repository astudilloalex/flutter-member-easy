import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:member_easy/src/company/domain/company.dart';
import 'package:member_easy/src/company/domain/i_company_repository.dart';
import 'package:member_easy/src/company/infrastructure/company_mapper.dart';

class FirebaseCompanyRepository implements ICompanyRepository {
  const FirebaseCompanyRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<List<Company>> findByOwnerCode(String ownerCode) async {
    final QuerySnapshot<Map<String, dynamic>> response = await _firestore
        .collection('companies')
        .where(
          'ownerCode',
          isEqualTo: ownerCode,
        )
        .get();
    return response.docs.map(
      (document) {
        return CompanyMapper.fromFirestore(document);
      },
    ).toList();
  }
}
