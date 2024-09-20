import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_easy/features/users/presentation/bloc/sign_in/sign_in_event.dart';
import 'package:member_easy/features/users/presentation/bloc/sign_in/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInStateInitial());
}
