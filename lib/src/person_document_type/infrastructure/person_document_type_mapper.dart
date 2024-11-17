import 'package:member_easy/src/country/infrastructure/country_mapper.dart';
import 'package:member_easy/src/person/infrastructure/person_mapper.dart';
import 'package:member_easy/src/person_document_type/domain/person_document_type.dart';

class PersonDocumentTypeMapper {
  const PersonDocumentTypeMapper._();

  static PersonDocumentType fromJson(Map<String, dynamic> map) {
    return PersonDocumentType(
      code: map['code'] as String,
      countryId: map['countryId'] as int,
      description: map['description'] as String?,
      id: map['id'] as int,
      name: map['name'] as String,
      country: map['country'] == null
          ? null
          : CountryMapper.fromJson(
              map['country'] as Map<String, dynamic>,
            ),
      people: map['people'] == null
          ? []
          : (map['people'] as List<dynamic>).map(
              (personJson) {
                return PersonMapper.fromJson(
                  personJson as Map<String, dynamic>,
                );
              },
            ).toList(),
    );
  }
}
