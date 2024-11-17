import 'package:equatable/equatable.dart';
import 'package:member_easy/app/models/optional.dart';
import 'package:member_easy/src/company/domain/company.dart';
import 'package:member_easy/src/user/domain/user.dart';

class AppState extends Equatable {
  const AppState({
    this.currentUser,
    this.currentCompany,
  });

  final Company? currentCompany;
  final User? currentUser;

  @override
  List<Object?> get props {
    return [
      currentCompany,
      currentUser,
    ];
  }

  AppState copyWith({
    Optional<Company?>? currentCompany,
    Optional<User?>? currentUser,
  }) {
    return AppState(
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
