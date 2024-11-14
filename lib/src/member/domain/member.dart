class Member {
  const Member({
    this.birthDate,
    this.code = '',
    required this.firstName,
    required this.idCard,
    required this.lastName,
  });

  final DateTime? birthDate;
  final String code;
  final String firstName;
  final String idCard;
  final String lastName;
}
