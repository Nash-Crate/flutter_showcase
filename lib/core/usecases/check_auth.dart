import 'package:flutter_showcase/core/core.dart';
import 'package:injectable/injectable.dart';

/// Usecase for checking the authentication status of the user
@singleton
class CheckAuth implements UsecaseNoParams<bool> {
  /// Constructor
  const CheckAuth(this._authRepository);

  final IAuthRepository _authRepository;

  @override
  AsyncFailT<bool> call() {
    return _authRepository.checkAuth();
  }
}
