import 'package:equatable/equatable.dart';
import 'package:member_easy/app/models/optional.dart';
import 'package:member_easy/src/member/domain/member.dart';

class AddEditMemberState extends Equatable {
  const AddEditMemberState({
    this.error = '',
    this.loading = false,
    this.member,
  });

  final String error;
  final bool loading;
  final Member? member;

  @override
  List<Object?> get props {
    return [
      error,
      loading,
      member,
    ];
  }

  AddEditMemberState copyWith({
    String? error,
    bool? loading,
    Optional<Member?>? member,
  }) {
    return AddEditMemberState(
      error: error ?? this.error,
      loading: loading ?? this.loading,
      member: member == null
          ? this.member
          : member.isPresent
              ? member.value
              : null,
    );
  }
}
