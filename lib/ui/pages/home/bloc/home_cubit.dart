import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/src/company/application/company_service.dart';
import 'package:member_easy/src/company/domain/company.dart';
import 'package:member_easy/src/summary/application/summary_service.dart';
import 'package:member_easy/src/summary/domain/summary.dart';
import 'package:member_easy/src/user/domain/user.dart';
import 'package:member_easy/ui/pages/home/bloc/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.companyService,
    required this.currentUser,
    required this.summaryService,
  }) : super(const HomeState()) {
    log('HomeCubit created', name: 'Cubit');
    init();
  }

  final CompanyService companyService;
  final User currentUser;
  final SummaryService summaryService;

  @override
  Future<void> close() {
    log('HomeCubit closed', name: 'Cubit');
    return super.close();
  }

  Future<void> init() async {
    if (isClosed) return;
    List<Company> companies = [];
    List<Summary> summaries = [];
    try {
      emit(state.copyWith(isLoading: true, companies: []));
      final Either<Failure, List<Company>> response =
          await companyService.byOnwerCode(currentUser.code);
      response.fold(
        (failure) {},
        (companyList) {
          companies = companyList;
        },
      );
      if (companies.isEmpty) return;
      final Either<Failure, List<Summary>> summaryResponse =
          await summaryService.byCompanyCode(
        companies.first.code,
      );
      summaryResponse.fold(
        (failure) {},
        (summaryList) {
          summaries = summaryList;
        },
      );
    } finally {
      if (!isClosed) {
        emit(
          state.copyWith(
            isLoading: false,
            companies: companies,
            summaries: summaries,
          ),
        );
      }
    }
  }
}
