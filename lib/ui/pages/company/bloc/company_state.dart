import 'package:equatable/equatable.dart';
import 'package:member_easy/app/models/optional.dart';
import 'package:member_easy/src/company/domain/company.dart';

class CompanyState extends Equatable {
  const CompanyState({
    this.companies = const <Company>[],
    this.error = '',
    this.isLoading = false,
    this.selectedCompany,
  });

  final List<Company> companies;
  final String error;
  final bool isLoading;
  final Company? selectedCompany;

  @override
  List<Object?> get props {
    return [
      companies,
      error,
      isLoading,
      selectedCompany,
    ];
  }

  CompanyState copyWith({
    List<Company>? companies,
    String? error,
    bool? isLoading,
    Optional<Company?>? selectedCompany,
  }) {
    return CompanyState(
      companies: companies ?? this.companies,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      selectedCompany: selectedCompany == null
          ? this.selectedCompany
          : selectedCompany.value,
    );
  }
}
