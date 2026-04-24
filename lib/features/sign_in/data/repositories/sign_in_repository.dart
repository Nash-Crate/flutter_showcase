import 'package:flutter_showcase/core/types/type_defs.dart';
import 'package:flutter_showcase/features/sign_in/sign_in.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Implementation of [ISignInRepository]
@Singleton(as: ISignInRepository)
class SignInRepository implements ISignInRepository {
  /// constructor
  const SignInRepository(this._datasource);

  final SignInDatasource _datasource;

  @override
  AsyncFailT<Unit> checkAuth() {
    return _datasource.checkAuth();
  }

  @override
  AsyncFailT<Unit> signInWithEmailAndPassword(EmailSignInDto dto) {
    return _datasource.signInWithEmailAndPassword(dto);
  }

  @override
  AsyncFailT<Unit> signInWithGoogle() {
    return _datasource.signInWithGoogle();
  }

  @override
  AsyncFailT<Unit> signOut() {
    return _datasource.signOut();
  }

  @override
  AsyncFailT<List<UserProfile>> getUserProfiles() {
    return _datasource.getUserProfiles();
  }

  @override
  AsyncFailT<UserProfile> getLastUsedUserProfile() {
    return _datasource.getLastUsedUserProfile();
  }
}
