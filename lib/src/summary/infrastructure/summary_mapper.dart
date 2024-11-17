import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:member_easy/src/summary/domain/summary.dart';

class SummaryMapper {
  const SummaryMapper._();

  static Summary fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final Map<String, dynamic> json = document.data();
    return Summary(
      code: document.id,
      id: json['id'] as int,
      name: json['name'] as String,
      value: json['value'] as String,
    );
  }
}
