import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignInStateInitial extends SignInState {
  const SignInStateInitial();
}
