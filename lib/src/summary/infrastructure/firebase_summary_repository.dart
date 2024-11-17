import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:member_easy/src/summary/domain/i_summary_repository.dart';
import 'package:member_easy/src/summary/domain/summary.dart';
import 'package:member_easy/src/summary/infrastructure/summary_mapper.dart';

class FirebaseSummaryRepository implements ISummaryRepository {
  const FirebaseSummaryRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<List<Summary>> findByCompanyCode(String companyCode) async {
    final QuerySnapshot<Map<String, dynamic>> response = await _firestore
        .collection('companies')
        .doc(companyCode)
        .collection('summaries')
        .get();
    return response.docs.map(
      (document) {
        return SummaryMapper.fromFirestore(document);
      },
    ).toList();
  }
}
