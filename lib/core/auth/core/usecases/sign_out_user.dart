import 'package:flutter_showcase/core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Usecase for signing out a user.
@singleton
class SignOutUser implements UsecaseNoParams<Unit> {
  /// constructor
  const SignOutUser(this._repository);

  final IAuthRepository _repository;

  @override
  AsyncFailT<Unit> call() {
    return _repository.signOut();
  }
}
