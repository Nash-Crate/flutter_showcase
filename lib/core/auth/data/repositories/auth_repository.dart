import 'package:flutter_showcase/core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Implementation of [IAuthRepository]
@Singleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  /// constructor
  const AuthRepository(this._datasource);

  final AuthDatasource _datasource;

  @override
  AsyncFailT<Unit> checkAuth() {
    return _datasource.checkAuth();
  }

  @override
  AsyncFailT<UserProfile> getLastUsedUserProfile() {
    return _datasource.getLastUsedUserProfile();
  }

  @override
  AsyncFailT<Unit> signOut() {
    return _datasource.signOut();
  }
}
