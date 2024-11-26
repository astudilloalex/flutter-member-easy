import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.error = '',
    this.isLoading = false,
    this.nextRoute = '',
  });

  final String error;
  final bool isLoading;
  final String nextRoute;

  @override
  List<Object?> get props {
    return [
      error,
      isLoading,
      nextRoute,
    ];
  }

  SignUpState copyWith({
    String? error,
    bool? isLoading,
    String? nextRoute,
  }) {
    return SignUpState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      nextRoute: nextRoute ?? this.nextRoute,
    );
  }
}
