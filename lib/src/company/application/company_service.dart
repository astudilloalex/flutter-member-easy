import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/src/company/domain/company.dart';
import 'package:member_easy/src/company/domain/i_company_repository.dart';

class CompanyService {
  const CompanyService(this._repository);

  final ICompanyRepository _repository;

  Future<Either<Failure, List<Company>>> byOnwerCode(String ownerCode) async {
    try {
      return Right(await _repository.findByOwnerCode(ownerCode));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }
}
