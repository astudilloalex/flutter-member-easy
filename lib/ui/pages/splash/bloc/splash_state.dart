import 'package:equatable/equatable.dart';
import 'package:member_easy/app/models/optional.dart';
import 'package:member_easy/src/company/domain/company.dart';
import 'package:member_easy/src/user/domain/user.dart';

class SplashState extends Equatable {
  const SplashState({
    this.companies = const <Company>[],
    this.error = '',
    this.nextRoute = '',
    this.user,
  });

  final List<Company> companies;
  final String error;
  final String nextRoute;
  final User? user;

  @override
  List<Object?> get props {
    return [
      companies,
      error,
      nextRoute,
      user,
    ];
  }

  SplashState copyWith({
    List<Company>? companies,
    String? error,
    String? nextRoute,
    Optional<User?>? user,
  }) {
    return SplashState(
      companies: companies ?? this.companies,
      error: error ?? this.error,
      nextRoute: nextRoute ?? this.nextRoute,
      user: user == null
          ? this.user
          : user.isPresent
              ? user.value
              : null,
    );
  }
}
