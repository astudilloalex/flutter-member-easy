import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_easy/src/auth/application/auth_service.dart';
import 'package:member_easy/src/user/domain/user.dart';
import 'package:member_easy/ui/pages/splash/bloc/splash_state.dart';
import 'package:member_easy/ui/routes/route_name.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this.authService,
  }) : super(const SplashState()) {
    log('SplashCubit create', name: 'Cubit');
    init();
  }

  final AuthService authService;

  @override
  Future<void> close() {
    log('SplashCubit closed', name: 'Cubit');
    return super.close();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final User? currentUser = await authService.currentUser;
    if (isClosed) return;
    emit(
      state.copyWith(
        nextRoute: currentUser == null ? RouteName.signIn : RouteName.home,
      ),
    );
  }
}
