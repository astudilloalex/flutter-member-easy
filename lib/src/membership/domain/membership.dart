class Membership {
  const Membership({
    required this.code,
    required this.id,
    required this.name,
    required this.cost,
  });

  final String code;
  final int id;
  final String name;
  final double cost;

  Membership copyWith({
    String? code,
    int? id,
    String? name,
    double? cost,
  }) {
    return Membership(
      code: code ?? this.code,
      id: id ?? this.id,
      name: name ?? this.name,
      cost: cost ?? this.cost,
    );
  }
}
