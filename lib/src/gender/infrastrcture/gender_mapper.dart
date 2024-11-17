import 'package:member_easy/src/gender/domain/gender.dart';
import 'package:member_easy/src/person/infrastructure/person_mapper.dart';

class GenderMapper {
  const GenderMapper._();

  static Gender fromJson(Map<String, dynamic> map) {
    return Gender(
      code: map['code'] as String,
      description: map['description'] as String?,
      id: map['id'] as int,
      name: map['name'] as String,
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
