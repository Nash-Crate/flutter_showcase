import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/sign_in/sign_in.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Usecase for sign in a user with email and password.
@singleton
class SignInUserEmail implements Usecase<Unit, EmailSignInDto> {
  /// constructor
  const SignInUserEmail(this._repository);

  final ISignInRepository _repository;

  @override
  AsyncFailT<Unit> call(EmailSignInDto dto) {
    return _repository.signInWithEmailAndPassword(dto);
  }
}
