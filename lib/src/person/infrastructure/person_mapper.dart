import 'package:member_easy/src/gender/infrastrcture/gender_mapper.dart';
import 'package:member_easy/src/person/domain/person.dart';
import 'package:member_easy/src/person_document_type/infrastructure/person_document_type_mapper.dart';

class PersonMapper {
  const PersonMapper._();

  static Person fromJson(Map<String, dynamic> map) {
    return Person(
      birthdate: map['birthdate'] == null
          ? null
          : DateTime.parse(map['birthdate'].toString()),
      code: map['code'] as String,
      documentTypeId: map['documentTypeId'] as int,
      firstName: map['firstName'] as String?,
      genderId: map['genderId'] as int?,
      id: map['id'] as int,
      idCard: map['idCard'] as String,
      juridicalPerson: map['juridicalPerson'] as bool,
      lastName: map['lastName'] as String?,
      socialReason: map['socialReason'] as String?,
      gender: map['gender'] == null
          ? null
          : GenderMapper.fromJson(
              map['gender'] as Map<String, dynamic>,
            ),
      documentType: PersonDocumentTypeMapper.fromJson(
        map['documentType'] as Map<String, dynamic>,
      ),
    );
  }
}
