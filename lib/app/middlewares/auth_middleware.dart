import 'dart:async';

import 'package:flutter/material.dart';
import 'package:member_easy/src/auth/application/auth_service.dart';
import 'package:member_easy/src/user/domain/user.dart';

class AuthMiddleware extends ChangeNotifier {
  AuthMiddleware(this.authService) {
    _subscription = authService.authStateChanges().listen((user) {
      _loggedIn = user != null;
      _currentUser = user;
      notifyListeners();
    });
  }

  final AuthService authService;
  late final StreamSubscription<User?> _subscription;
  bool _loggedIn = true;
  User? _currentUser;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  bool get loggedIn => _loggedIn;
  User? get currentUser => _currentUser;
}
