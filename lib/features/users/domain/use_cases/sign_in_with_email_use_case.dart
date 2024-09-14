import 'package:fpdart/fpdart.dart';
import 'package:member_easy/core/error/failure.dart';
import 'package:member_easy/features/users/domain/entities/user.dart';
import 'package:member_easy/features/users/domain/repositories/i_user_repository.dart';

class SignInWithEmailUseCase {
  const SignInWithEmailUseCase({
    required this.userRepository,
  });

  final IUserRepository userRepository;

  Future<Either<Failure, User>> execute({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return const Left(InvalidInputFailure());
    }
    try {
      return Right(
        await userRepository.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
