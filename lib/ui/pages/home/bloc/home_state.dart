import 'package:equatable/equatable.dart';
import 'package:member_easy/src/company/domain/company.dart';
import 'package:member_easy/src/member/domain/member.dart';
import 'package:member_easy/src/summary/domain/summary.dart';

class HomeState extends Equatable {
  const HomeState({
    this.companies = const <Company>[],
    this.isLoading = false,
    this.members = const <Member>[],
    this.summaries = const <Summary>[],
  });

  final List<Company> companies;
  final bool isLoading;
  final List<Member> members;
  final List<Summary> summaries;

  @override
  List<Object?> get props {
    return [
      companies,
      isLoading,
      members,
      summaries,
    ];
  }

  HomeState copyWith({
    List<Company>? companies,
    bool? isLoading,
    List<Member>? members,
    List<Summary>? summaries,
  }) {
    return HomeState(
      companies: companies ?? this.companies,
      isLoading: isLoading ?? this.isLoading,
      members: members ?? this.members,
      summaries: summaries ?? this.summaries,
    );
  }
}
