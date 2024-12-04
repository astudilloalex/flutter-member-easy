import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/src/member/domain/member.dart';

abstract class IMemberRepository {
  const IMemberRepository();

  Future<List<Member>> findByCompanyCode(
    String companyCode, {
    Member? lastMember,
    int limit = 25,
  });

  Future<Either<Failure, Member>> save(
    Member member, {
    required String companyCode,
  });

  Future<Either<Failure, Member>> update(
    Member member, {
    required String companyCode,
  });
}
