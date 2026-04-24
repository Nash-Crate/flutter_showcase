import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/sign_up/sign_up.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// Data source for authentication, implements the [ISignUpRepository] interface.
abstract class SignUpDatasource with ISignUpRepository {}

/// Implementation of the [SignUpDatasource] interface.
@Singleton(as: SignUpDatasource)
class SignUpDatasourceImpl implements SignUpDatasource {
  /// Constructor for the [SignUpDatasourceImpl] class.
  const SignUpDatasourceImpl(this._supabaseClient);

  final supabase.SupabaseClient _supabaseClient;

  @override
  AsyncFailT<Unit> signUpWithEmailAndPassword(EmailSignUpDto dto) async {
    try {
      // create authentication record
      final a = await _supabaseClient.auth.signUp(
        email: dto.email,
        password: dto.password,
        // pass the name as user metadata for the profile record
        data: {
          'name': dto.name,
        },
      );

      return const Right(unit);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }
}
