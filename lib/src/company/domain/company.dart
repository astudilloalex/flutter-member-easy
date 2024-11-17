import 'package:member_easy/src/person/domain/person.dart';

class Company {
  const Company({
    this.id = 0,
    required this.personId,
    this.code = '',
    required this.tradename,
    this.description,
    this.imageURL,
    this.maxCustomers = 0,
    required this.ownerCode,
    required this.person,
  });

  final int id;
  final int personId;
  final String code;
  final String tradename;
  final String? description;
  final String? imageURL;
  final int maxCustomers;
  final String ownerCode;
  final Person person;

  Company copyWith({
    int? id,
    int? personId,
    String? code,
    String? tradename,
    String? description,
    String? imageURL,
    int? maxCustomers,
    String? ownerCode,
    Person? person,
  }) {
    return Company(
      id: id ?? this.id,
      personId: personId ?? this.personId,
      code: code ?? this.code,
      tradename: tradename ?? this.tradename,
      description: description ?? this.description,
      imageURL: imageURL ?? this.imageURL,
      maxCustomers: maxCustomers ?? this.maxCustomers,
      ownerCode: ownerCode ?? this.ownerCode,
      person: person ?? this.person,
    );
  }
}
