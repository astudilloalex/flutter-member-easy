abstract class Failure {
  final String? message;
  final int? code;

  const Failure({this.message, this.code});

  @override
  String toString() => message ?? 'An unknown error occurred';
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure({super.message});
}

class ServerFailure extends Failure {
  const ServerFailure({super.message});
}
