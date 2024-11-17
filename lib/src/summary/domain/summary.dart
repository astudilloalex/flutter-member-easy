class Summary {
  const Summary(
      {this.code = '', this.id = 0, required this.name, required this.value});

  final String code;
  final int id;
  final String name;
  final String value;

  Summary copyWith({
    String? code,
    int? id,
    String? name,
    String? value,
  }) {
    return Summary(
      code: code ?? this.code,
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }
}
