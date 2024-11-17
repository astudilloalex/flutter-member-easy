import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/src/membership/domain/i_membership_repository.dart';
import 'package:member_easy/src/membership/domain/membership.dart';

class MembershipService {
  const MembershipService(this._repository);

  final IMembershipRepository _repository;

  Future<Either<Failure, List<Membership>>> byCompanyCode(
    String companyCode,
  ) async {
    try {
      return Right(await _repository.findByCompanyCode(companyCode));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }
}
