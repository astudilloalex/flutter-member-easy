import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/src/user/domain/i_user_repository.dart';
import 'package:member_easy/src/user/domain/user.dart';

class UserService {
  const UserService(this._repository);

  final IUserRepository _repository;

  Future<Either<Failure, User>> createOrUpdate(User user) async {
    try {
      return Right(await _repository.saveOrUpdate(user));
    } catch (e) {
      return Left(
        FirebaseFailure(message: e.toString()),
      );
    }
  }

  Future<Either<Failure, User>> getByCode(String code) async {
    try {
      final User? user = await _repository.findByCode(code);
      if (user == null) {
        return const Left(
          ServiceFailure(
            failureEnum: FailureEnum.userNotFound,
          ),
        );
      }
      return Right(user);
    } catch (e) {
      return Left(
        ServiceFailure(message: e.toString()),
      );
    }
  }
}
