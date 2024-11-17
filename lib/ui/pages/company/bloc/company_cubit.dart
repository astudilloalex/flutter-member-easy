import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/app/models/optional.dart';
import 'package:member_easy/src/company/application/company_service.dart';
import 'package:member_easy/src/company/domain/company.dart';
import 'package:member_easy/src/user/domain/user.dart';
import 'package:member_easy/ui/pages/company/bloc/company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit({
    required this.companyService,
    required this.currentUser,
  }) : super(const CompanyState()) {
    log('CompanyCubit created', name: 'Cubit');
    init();
  }

  final CompanyService companyService;
  final User currentUser;

  @override
  Future<void> close() {
    log('CompanyCubit closed', name: 'Cubit');
    return super.close();
  }

  Future<void> init() async {
    if (isClosed) return;
    List<Company> companies = [];
    Company? selectedCompany;
    try {
      emit(
        state.copyWith(
          isLoading: true,
          error: '',
        ),
      );
      final Either<Failure, List<Company>> response =
          await companyService.byOnwerCode(
        currentUser.code,
      );
      response.fold(
        (failure) {},
        (companyList) {
          companies = companyList;
        },
      );
    } catch (e) {
      rethrow;
    } finally {
      emit(
        state.copyWith(
          isLoading: false,
          companies: companies,
          selectedCompany: Optional.of(companies.firstOrNull),
        ),
      );
    }
  }
}
