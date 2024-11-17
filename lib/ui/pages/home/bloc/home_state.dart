import 'package:equatable/equatable.dart';
import 'package:member_easy/src/company/domain/company.dart';
import 'package:member_easy/src/member/domain/member.dart';

class HomeState extends Equatable {
  const HomeState({
    this.companies = const <Company>[],
    this.isLoading = false,
    this.members = const <Member>[],
  });

  final List<Company> companies;
  final bool isLoading;
  final List<Member> members;

  @override
  List<Object?> get props {
    return [
      companies,
      isLoading,
      members,
    ];
  }

  HomeState copyWith({
    List<Company>? companies,
    bool? isLoading,
    List<Member>? members,
  }) {
    return HomeState(
      companies: companies ?? this.companies,
      isLoading: isLoading ?? this.isLoading,
      members: members ?? this.members,
    );
  }
}
