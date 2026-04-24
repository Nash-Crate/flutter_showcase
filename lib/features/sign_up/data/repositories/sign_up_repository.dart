import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/sign_up/sign_up.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Repository for authentication, implements the [ISignUpRepository] interface.
@Singleton(as: ISignUpRepository)
class SignUpRepository implements ISignUpRepository {
  /// constructor
  const SignUpRepository(this._datasource);

  final SignUpDatasource _datasource;

  @override
  AsyncFailT<Unit> signUpWithEmailAndPassword(EmailSignUpDto dto) {
    return _datasource.signUpWithEmailAndPassword(dto);
  }
}
