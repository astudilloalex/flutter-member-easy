class AppUtil {
  const AppUtil._();

  static bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    return emailRegex.hasMatch(email);
  }

  static bool isSecurePassword(String password) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#\$&*~.])[A-Za-z\d!@#\$&*~.]{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }
}
