extension StringValidation on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    return passwordRegExp.hasMatch(this);
  }

  bool get hasAtLeast8Chars {
    return length >= 8;
  }

  bool get hasOneNumAndOneLetter {
    final regExp = RegExp(
      '^(?=.*?[A-Z])(?=.*?[0-9])',
    );
    return regExp.hasMatch(this);
  }

  bool get hasOneSpecialChar {
    final regExp = RegExp(
      r'^(?=.*[@$!%*#?&])',
    );
    return regExp.hasMatch(this);
  }
}
