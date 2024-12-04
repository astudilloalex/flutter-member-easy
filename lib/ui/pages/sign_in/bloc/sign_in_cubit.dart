import 'dart:developer';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/app/utils/app_util.dart';
import 'package:member_easy/src/auth/application/auth_service.dart';
import 'package:member_easy/src/user/domain/user.dart';
import 'package:member_easy/ui/pages/sign_in/bloc/sign_in_state.dart';
import 'package:member_easy/ui/routes/route_name.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required this.authService,
  }) : super(const SignInState()) {
    log('SignInCubit created', name: 'Cubit');
  }

  final AuthService authService;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    log('SignInCubit closed', name: 'Cubit');
    return super.close();
  }

  Future<void> signInWithGoogle() async {
    if (isClosed) return;
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
      final Either<Failure, User> response = await authService.signInWithGoogle(
        isWeb: kIsWeb,
      );
      response.fold(
        (failure) {
          error = failure.code;
        },
        (user) {
          nextRoute = RouteName.splash;
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

  Future<void> signInWithEmailAndPassword() async {
    if (isClosed) return;
    String error = '';
    String nextRoute = '';
    try {
      if (formKey.currentState == null || !formKey.currentState!.validate()) {
        return;
      }
      emit(
        state.copyWith(
          isLoading: true,
          error: error,
          nextRoute: nextRoute,
        ),
      );
      final Either<Failure, User> response =
          await authService.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      response.fold(
        (failure) {
          error = failure.code;
        },
        (user) {
          nextRoute = RouteName.splash;
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

  String? validateEmail(String? value) {
    if (value == null || !AppUtil.isValidEmail(value.trim())) {
      return 'invalid-email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || !AppUtil.isSecurePassword(value.trim())) {
      return 'weak-password';
    }
    return null;
  }
}
