import 'package:member_easy/src/person_document_type/domain/person_document_type.dart';

class Country {
  const Country({
    this.id = 0,
    this.code = '',
    required this.name,
    this.description,
    this.personDocumentTypes = const <PersonDocumentType>[],
  });

  final int id;
  final String code;
  final String name;
  final String? description;
  final List<PersonDocumentType> personDocumentTypes;

  Country copyWith({
    int? id,
    String? code,
    String? name,
    String? description,
    List<PersonDocumentType>? personDocumentTypes,
  }) {
    return Country(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      personDocumentTypes: personDocumentTypes ?? this.personDocumentTypes,
    );
  }
}
