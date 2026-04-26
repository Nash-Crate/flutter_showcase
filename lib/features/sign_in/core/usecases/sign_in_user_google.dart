import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/sign_in/sign_in.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Usecase for signing in a user with Google.
@singleton
class SignInUserGoogle implements UsecaseNoParams<Unit> {
  /// constructor
  const SignInUserGoogle(this._repository);

  final ISignInRepository _repository;

  @override
  AsyncFailT<Unit> call() {
    return _repository.signInWithGoogle();
  }
}
