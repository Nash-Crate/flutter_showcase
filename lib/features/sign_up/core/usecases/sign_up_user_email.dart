import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/sign_up/sign_up.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Usecase for sign up a user with email and password.
@singleton
class SignUpUserEmail implements Usecase<Unit, EmailSignUpDto> {
  /// constructor
  const SignUpUserEmail(this._repository);

  final ISignUpRepository _repository;

  @override
  AsyncFailT<Unit> call(EmailSignUpDto dto) {
    return _repository.signUpWithEmailAndPassword(dto);
  }
}
