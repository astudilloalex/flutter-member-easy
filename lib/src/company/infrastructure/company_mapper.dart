import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:member_easy/src/company/domain/company.dart';
import 'package:member_easy/src/person/infrastructure/person_mapper.dart';

class CompanyMapper {
  const CompanyMapper._();

  static Company fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final Map<String, dynamic> json = document.data();
    return Company(
      code: document.id,
      description: json['description'] as String?,
      id: json['id'] as int,
      imageURL: json['imageURL'] as String?,
      personId: json['personId'] as int,
      tradename: json['tradename'] as String,
      maxCustomers: json['maxCustomers'] as int? ?? 0,
      ownerCode: json['ownerCode'] as String,
      person: PersonMapper.fromJson(json['person'] as Map<String, dynamic>),
    );
  }
}
