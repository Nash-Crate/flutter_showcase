// Following "Really Obvious Code" (ROC),
// ignore_for_file: public_member_api_docs

import 'package:flutter_showcase/core/core.dart';
import 'package:fpdart/fpdart.dart';

class EmailAddress extends ValueObject<String> {
  factory EmailAddress(String? input) {
    return EmailAddress._(validateEmailAddress(input));
  }

  const EmailAddress._(this.value);

  @override
  final Either<ValueFailure<String?>, String> value;
}

class Password extends ValueObject<String> {
  factory Password(String? input, {String? confirmPassword}) {
    return Password._(validatePassword(input, confirmPassword: confirmPassword));
  }

  const Password._(this.value);

  @override
  final Either<ValueFailure<String?>, String> value;
}

class ConfirmPassword extends ValueObject<String> {
  factory ConfirmPassword(String? input, {required String? password}) {
    return ConfirmPassword._(validateConfirmPassword(input, password: password));
  }

  const ConfirmPassword._(this.value);

  @override
  final Either<ValueFailure<String?>, String> value;
}
