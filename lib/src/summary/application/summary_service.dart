import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/src/summary/domain/i_summary_repository.dart';
import 'package:member_easy/src/summary/domain/summary.dart';

class SummaryService {
  const SummaryService(this._repository);

  final ISummaryRepository _repository;

  Future<Either<Failure, List<Summary>>> byCompanyCode(
    String companyCode,
  ) async {
    try {
      return Right(await _repository.findByCompanyCode(companyCode));
    } catch (e) {
      return Left(FirebaseFailure(message: e.toString()));
    }
  }
}
