class Attendance {
  const Attendance({
    this.code = '',
    required this.date,
  });

  final String code;
  final DateTime date;

  Attendance copyWith({
    String? code,
    DateTime? date,
  }) {
    return Attendance(
      code: code ?? this.code,
      date: date ?? this.date,
    );
  }
}
