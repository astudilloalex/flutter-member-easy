import 'package:equatable/equatable.dart';
import 'package:member_easy/src/member/domain/member.dart';

class HomeState extends Equatable {
  const HomeState({
    this.isLoading = false,
    this.members = const <Member>[],
  });

  final bool isLoading;
  final List<Member> members;

  @override
  List<Object?> get props {
    return [
      isLoading,
      members,
    ];
  }

  HomeState copyWith({
    bool? isLoading,
    List<Member>? members,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      members: members ?? this.members,
    );
  }
}
