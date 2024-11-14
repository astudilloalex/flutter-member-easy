class User {
  const User({
    required this.code,
    this.displayName,
    this.email,
    this.emailVerified = false,
    this.isAnonymous = false,
    this.phoneNumber,
    this.photoURL,
    this.refreshToken,
    this.tenantId,
  });

  final String code;
  final String? displayName;
  final String? email;
  final bool emailVerified;
  final bool isAnonymous;
  final String? phoneNumber;
  final String? photoURL;
  final String? refreshToken;
  final String? tenantId;

  User copyWith({
    String? code,
    String? displayName,
    String? email,
    bool? emailVerified,
    bool? isAnonymous,
    String? phoneNumber,
    String? photoURL,
    String? refreshToken,
    String? tenantId,
  }) {
    return User(
      code: code ?? this.code,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL ?? this.photoURL,
      refreshToken: refreshToken ?? this.refreshToken,
      tenantId: tenantId ?? this.tenantId,
    );
  }
}
