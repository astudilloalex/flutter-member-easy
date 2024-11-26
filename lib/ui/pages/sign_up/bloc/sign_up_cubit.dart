import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/src/auth/application/auth_service.dart';
import 'package:member_easy/src/user/domain/user.dart';
import 'package:member_easy/ui/pages/sign_up/bloc/sign_up_state.dart';
import 'package:member_easy/ui/routes/route_name.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required this.authService,
  }) : super(const SignUpState()) {
    log('SignUpCubit created', name: 'Cubit');
  }

  final AuthService authService;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    log('SignUpCubit closed', name: 'Cubit');
    return super.close();
  }

  Future<void> signUp() async {
    if (isClosed) return;
    if (!formKey.currentState!.validate()) return;
    String error = '';
    String nextRoute = '';
    try {
      emit(
        state.copyWith(
          isLoading: true,
          error: error,
          nextRoute: nextRoute,
        ),
      );
      final Either<Failure, User> response =
          await authService.signUpWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      response.fold(
        (failure) {
          error = failure.message;
        },
        (user) {
          nextRoute = RouteName.home;
        },
      );
    } finally {
      if (!isClosed) {
        emit(
          state.copyWith(
            isLoading: false,
            error: error,
            nextRoute: nextRoute,
          ),
        );
      }
    }
  }
}
