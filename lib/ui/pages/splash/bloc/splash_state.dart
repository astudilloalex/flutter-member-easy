import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  const SplashState({
    this.nextRoute = '',
  });

  final String nextRoute;

  @override
  List<Object?> get props {
    return [
      nextRoute,
    ];
  }

  SplashState copyWith({
    String? nextRoute,
  }) {
    return SplashState(
      nextRoute: nextRoute ?? this.nextRoute,
    );
  }
}
