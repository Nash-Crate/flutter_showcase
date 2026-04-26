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
  AsyncFailT<Unit> signInWithEmailAndPassword(EmailSignInDto dto) {
    return _datasource.signInWithEmailAndPassword(dto);
  }

  @override
  AsyncFailT<Unit> signInWithGoogle() {
    return _datasource.signInWithGoogle();
  }
}
