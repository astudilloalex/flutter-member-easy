import 'package:member_easy/src/country/domain/country.dart';
import 'package:member_easy/src/person/domain/person.dart';

class PersonDocumentType {
  const PersonDocumentType({
    this.id = 0,
    this.countryId = 0,
    this.code = '',
    required this.name,
    this.description,
    this.country,
    this.people = const <Person>[],
  });

  final int id;
  final int countryId;
  final String code;
  final String name;
  final String? description;
  final Country? country;
  final List<Person> people;

  PersonDocumentType copyWith({
    int? id,
    int? countryId,
    String? code,
    String? name,
    String? description,
    Country? country,
    List<Person>? people,
  }) {
    return PersonDocumentType(
      id: id ?? this.id,
      countryId: countryId ?? this.countryId,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      country: country ?? this.country,
      people: people ?? this.people,
    );
  }
}
