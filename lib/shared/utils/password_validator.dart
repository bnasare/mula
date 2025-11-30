class PasswordValidator {
  static const int minLength = 8;

  static String? validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your current password';
    }
    return null;
  }

  static String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a new password';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String newPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your new password';
    }

    if (value != newPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  static String? validatePin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your PIN';
    }

    if (value.length != 4) {
      return 'PIN must be 4 digits';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'PIN must contain only numbers';
    }

    return null;
  }

  static bool arePasswordsDifferent(String currentPassword, String newPassword) {
    return currentPassword != newPassword;
  }
}
