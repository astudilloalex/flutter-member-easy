import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/core/app_session_data.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/src/member/domain/i_member_repository.dart';
import 'package:member_easy/src/member/domain/member.dart';

class MemberService {
  const MemberService(this._repository);

  final IMemberRepository _repository;

  Future<Either<Failure, Member>> byCode(String code) async {
    try {
      if (AppSessionData.company == null) {
        return const Left(
          ServiceFailure(
            failureEnum: FailureEnum.thereIsNoCompanySelected,
          ),
        );
      }
      return await _repository.findByCompanyCodeAndCode(
        AppSessionData.company!.code,
        code,
      );
    } catch (e) {
      return Left(ServiceFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<Member>>> all({
    int limit = 25,
    Member? lastMember,
  }) async {
    try {
      if (AppSessionData.company == null) {
        return const Left(
          ServiceFailure(
            failureEnum: FailureEnum.thereIsNoCompanySelected,
          ),
        );
      }
      final List<Member> data = await _repository.findByCompanyCode(
        AppSessionData.company!.code,
        lastMember: lastMember,
        limit: limit,
      );
      return Right(data);
    } catch (e) {
      return Left(ServiceFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Member>> create(Member member) async {
    try {
      if (AppSessionData.company == null) {
        return const Left(
          ServiceFailure(
            failureEnum: FailureEnum.thereIsNoCompanySelected,
          ),
        );
      }
      final int count = await _repository.count(AppSessionData.company!.code);
      if (count >= AppSessionData.company!.maxCustomers) {
        return const Left(
          ServiceFailure(failureEnum: FailureEnum.maximumNumberMembersReached),
        );
      }
      return await _repository.save(
        member,
        companyCode: AppSessionData.company!.code,
      );
    } catch (e) {
      return Left(ServiceFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Member>> update(Member member) async {
    try {
      if (AppSessionData.company == null) {
        return const Left(
          ServiceFailure(
            failureEnum: FailureEnum.thereIsNoCompanySelected,
          ),
        );
      }
      return await _repository.update(
        member,
        companyCode: AppSessionData.company!.code,
      );
    } catch (e) {
      return Left(ServiceFailure(message: e.toString()));
    }
  }
}
