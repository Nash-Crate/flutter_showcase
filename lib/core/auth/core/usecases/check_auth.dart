import 'package:flutter_showcase/core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Usecase for checking the authentication status of the user
@singleton
class CheckAuth implements UsecaseNoParams<Unit> {
  /// Constructor
  const CheckAuth(this._authRepository);

  final IAuthRepository _authRepository;

  @override
  AsyncFailT<Unit> call() {
    return _authRepository.checkAuth();
  }
}
