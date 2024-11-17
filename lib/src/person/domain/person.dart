import 'package:member_easy/src/gender/domain/gender.dart';
import 'package:member_easy/src/person_document_type/domain/person_document_type.dart';

class Person {
  const Person({
    this.id = 0,
    required this.documentTypeId,
    this.genderId,
    this.code = '',
    required this.idCard,
    this.firstName,
    this.lastName,
    this.socialReason,
    this.birthdate,
    this.juridicalPerson = false,
    this.gender,
    required this.documentType,
  });

  final int id;
  final int documentTypeId;
  final int? genderId;
  final String code;
  final String idCard;
  final String? firstName;
  final String? lastName;
  final String? socialReason;
  final DateTime? birthdate;
  final bool juridicalPerson;
  final Gender? gender;
  final PersonDocumentType documentType;

  Person copyWith({
    int? id,
    int? documentTypeId,
    int? genderId,
    String? code,
    String? idCard,
    String? firstName,
    String? lastName,
    String? socialReason,
    DateTime? birthdate,
    bool? juridicalPerson,
    Gender? gender,
    PersonDocumentType? documentType,
  }) {
    return Person(
      id: id ?? this.id,
      documentTypeId: documentTypeId ?? this.documentTypeId,
      genderId: genderId ?? this.genderId,
      code: code ?? this.code,
      idCard: idCard ?? this.idCard,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      socialReason: socialReason ?? this.socialReason,
      birthdate: birthdate ?? this.birthdate,
      juridicalPerson: juridicalPerson ?? this.juridicalPerson,
      gender: gender ?? this.gender,
      documentType: documentType ?? this.documentType,
    );
  }
}
