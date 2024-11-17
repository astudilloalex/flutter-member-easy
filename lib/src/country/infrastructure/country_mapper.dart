import 'package:member_easy/src/country/domain/country.dart';
import 'package:member_easy/src/person_document_type/infrastructure/person_document_type_mapper.dart';

class CountryMapper {
  const CountryMapper._();

  static Country fromJson(Map<String, dynamic> map) {
    return Country(
      code: map['code'] as String,
      description: map['description'] as String?,
      id: map['id'] as int,
      name: map['name'] as String,
      personDocumentTypes: map['personDocumentTypes'] == null
          ? []
          : (map['personDocumentTypes'] as List<dynamic>).map(
              (documentTypeJson) {
                return PersonDocumentTypeMapper.fromJson(
                  documentTypeJson as Map<String, dynamic>,
                );
              },
            ).toList(),
    );
  }
}
