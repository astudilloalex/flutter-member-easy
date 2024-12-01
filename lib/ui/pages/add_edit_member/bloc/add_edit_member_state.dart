import 'package:equatable/equatable.dart';

class AddEditMemberState extends Equatable {
  const AddEditMemberState({
    this.loading = false,
  });

  final bool loading;

  @override
  List<Object?> get props {
    return [
      loading,
    ];
  }
}
