import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/app/models/optional.dart';
import 'package:member_easy/src/auth/application/auth_service.dart';
import 'package:member_easy/src/company/application/company_service.dart';
import 'package:member_easy/src/company/domain/company.dart';
import 'package:member_easy/src/user/domain/user.dart';
import 'package:member_easy/ui/pages/splash/bloc/splash_state.dart';
import 'package:member_easy/ui/routes/route_name.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this.authService,
    required this.companyService,
  }) : super(const SplashState()) {
    log('SplashCubit create', name: 'Cubit');
    init();
  }

  final AuthService authService;
  final CompanyService companyService;

  @override
  Future<void> close() {
    log('SplashCubit closed', name: 'Cubit');
    return super.close();
  }

  Future<void> init() async {
    if (isClosed) return;
    List<Company> companies = [];
    User? currentUser;
    String error = '';
    String nextRoute = '';
    try {
      emit(
        state.copyWith(
          companies: companies,
          error: error,
          nextRoute: nextRoute,
          user: Optional.empty(),
        ),
      );
      // Get current user.
      currentUser = await authService.currentUser;
      if (currentUser == null) {
        nextRoute = RouteName.signIn;
        return;
      }

      // Get available companies.
      final Either<Failure, List<Company>> response =
          await companyService.byOnwerCode(
        currentUser.code,
      );
      response.fold(
        (failure) {
          error = failure.message;
        },
        (data) {
          companies = data;
          nextRoute = RouteName.home;
        },
      );
    } finally {
      emit(
        state.copyWith(
          companies: companies,
          error: error,
          nextRoute: nextRoute,
          user: Optional.of(currentUser),
        ),
      );
    }
  }
}
