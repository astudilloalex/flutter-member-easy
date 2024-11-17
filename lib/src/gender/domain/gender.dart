import 'package:member_easy/src/person/domain/person.dart';

class Gender {
  const Gender({
    this.id = 0,
    this.code = '',
    required this.name,
    this.description,
    this.people = const <Person>[],
  });

  final int id;
  final String code;
  final String name;
  final String? description;
  final List<Person> people;

  Gender copyWith({
    int? id,
    String? code,
    String? name,
    String? description,
    List<Person>? people,
  }) {
    return Gender(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      people: people ?? this.people,
    );
  }
}
