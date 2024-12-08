import 'package:equatable/equatable.dart';
import 'package:member_easy/src/member/domain/member.dart';

class MemberState extends Equatable {
  const MemberState({
    this.loading = false,
    this.members = const <Member>[],
  });

  final bool loading;
  final List<Member> members;

  @override
  List<Object?> get props {
    return [
      loading,
      members,
    ];
  }

  MemberState copyWith({
    bool? loading,
    List<Member>? members,
  }) {
    return MemberState(
      loading: loading ?? this.loading,
      members: members ?? this.members,
    );
  }
}
