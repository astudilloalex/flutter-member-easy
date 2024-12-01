import 'package:equatable/equatable.dart';
import 'package:member_easy/app/models/optional.dart';
import 'package:member_easy/src/company/domain/company.dart';
import 'package:member_easy/src/user/domain/user.dart';

class AppState extends Equatable {
  const AppState({
    this.closingSession = false,
    this.companies = const <Company>[],
    this.currentUser,
    this.currentCompany,
  });

  final bool closingSession;
  final List<Company> companies;
  final Company? currentCompany;
  final User? currentUser;

  @override
  List<Object?> get props {
    return [
      closingSession,
      companies,
      currentCompany,
      currentUser,
    ];
  }

  AppState copyWith({
    bool? closingSession,
    List<Company>? companies,
    Optional<Company?>? currentCompany,
    Optional<User?>? currentUser,
  }) {
    return AppState(
      closingSession: closingSession ?? this.closingSession,
      companies: companies ?? this.companies,
      currentCompany: currentCompany == null
          ? this.currentCompany
          : currentCompany.isPresent
              ? currentCompany.value
              : null,
      currentUser: currentUser == null
          ? this.currentUser
          : currentUser.isPresent
              ? currentUser.value
              : null,
    );
  }
}
