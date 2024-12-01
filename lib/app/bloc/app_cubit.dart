import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_easy/app/bloc/app_state.dart';
import 'package:member_easy/app/models/optional.dart';
import 'package:member_easy/src/auth/application/auth_service.dart';
import 'package:member_easy/src/company/domain/company.dart';
import 'package:member_easy/src/user/domain/user.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required this.authService,
  }) : super(const AppState()) {
    log('AppCubit created', name: 'Cubit');
  }

  final AuthService authService;

  @override
  Future<void> close() {
    log('AppCubit closed', name: 'Cubit');
    return super.close();
  }

  void updateCurrentUser(User? user) {
    emit(
      state.copyWith(
        currentUser: Optional.of<User?>(user),
      ),
    );
  }

  void changeCurrentCompany(Company company) {
    emit(
      state.copyWith(
        currentCompany: Optional.of<Company?>(company),
      ),
    );
  }

  void updateCompanies(List<Company> companies) {
    emit(state.copyWith(companies: companies));
  }

  Future<void> logout() async {
    try {
      emit(state.copyWith(closingSession: true));
      await authService.signOut();
    } finally {
      emit(state.copyWith(closingSession: false));
    }
  }
}
