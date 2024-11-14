abstract class Failure {
  const Failure(this.message);

  final String message;
}

class FirebaseFailure extends Failure {
  const FirebaseFailure(super.message);
}
