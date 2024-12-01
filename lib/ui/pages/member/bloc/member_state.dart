import 'package:equatable/equatable.dart';

class MemberState extends Equatable {
  const MemberState({
    this.loading = false,
  });

  final bool loading;

  @override
  List<Object?> get props {
    return [
      loading,
    ];
  }

  MemberState copyWith({
    bool? loading,
  }) {
    return MemberState(
      loading: loading ?? this.loading,
    );
  }
}
