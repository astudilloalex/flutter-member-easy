import 'package:member_easy/src/user/domain/user.dart';

class Member {
  const Member({
    this.birthdate,
    this.code = '',
    required this.firstName,
    required this.idCard,
    this.isActive = false,
    required this.joinedAt,
    required this.lastName,
    this.user,
  }) : fullName = '$firstName $lastName';

  final DateTime? birthdate;
  final String code;
  final String firstName;
  final String fullName;
  final String idCard;
  final bool isActive;
  final DateTime joinedAt;
  final String lastName;
  final User? user;

  Member copyWith({
    DateTime? birthdate,
    String? code,
    String? firstName,
    String? idCard,
    bool? isActive,
    DateTime? joinedAt,
    String? lastName,
    User? user,
  }) {
    return Member(
      birthdate: birthdate ?? this.birthdate,
      code: code ?? this.code,
      firstName: firstName ?? this.firstName,
      idCard: idCard ?? this.idCard,
      isActive: isActive ?? this.isActive,
      joinedAt: joinedAt ?? this.joinedAt,
      lastName: lastName ?? this.lastName,
      user: user ?? this.user,
    );
  }
}
