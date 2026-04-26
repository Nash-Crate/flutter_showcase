import 'dart:convert';

import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/sign_in/sign_in.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// Data source for authentication, implements the [ISignInRepository] interface.
abstract class SignInDatasource with ISignInRepository {}

/// Implementation of the [SignInDatasource] interface.
@Singleton(as: SignInDatasource)
class SignInDatasourceImpl implements SignInDatasource {
  /// Constructor for the [SignInDatasourceImpl] class.
  const SignInDatasourceImpl(this._supabaseClient, this._cacheStorage, this._googleSignIn);

  final supabase.SupabaseClient _supabaseClient;
  final ICacheStorage _cacheStorage;
  final GoogleSignIn _googleSignIn;

  @override
  AsyncFailT<Unit> signInWithEmailAndPassword(EmailSignInDto dto) async {
    try {
      final res = await _supabaseClient.auth.signInWithPassword(
        email: dto.email,
        password: dto.password,
      );
      if (res.session == null || res.user == null) {
        return const Left(Failure.unexpectedError('Failed to sign in with email and password'));
      }

      final sessionString = jsonEncode(res.session);
      await _cacheStorage.upsert<String>(key: AuthCacheKeys.userSession, data: sessionString);

      return const Right(unit);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }

  @override
  AsyncFailT<Unit> signOut() async {
    try {
      await _supabaseClient.auth.signOut();

      return const Right(unit);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }

  @override
  AsyncFailT<Unit> checkAuth() async {
    try {
      final cachedSessionRes = await _cacheStorage.read<String>(key: AuthCacheKeys.userSession);
      if (cachedSessionRes == null) {
        return const Left(Failure.authFailure(AuthFailure.noPreviousAuth()));
      }

      final sessionRes = jsonDecode(cachedSessionRes);
      // TODO(fix): add a json encode model
      await _supabaseClient.auth.setSession(sessionRes['refresh_token']! as String);

      final userId = _supabaseClient.auth.currentUser?.id;
      if (userId == null) {
        return const Left(Failure.unexpectedError('Failed to get user id from session'));
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }

  @override
  AsyncFailT<Unit> signInWithGoogle() async {
    if (GoogleSignIn.instance.supportsAuthenticate()) {
      return const Left(
        Failure.unexpectedError('Google Sign-In is not supported on this platform'),
      );
    }

    try {
      // sign in to google and get the id token
      final googleUser = await _googleSignIn.authenticate();
      final idToken = googleUser.authentication.idToken;
      if (idToken == null) {
        return const Left(
          Failure.authFailure(
            AuthFailure.failed(message: 'Failed to get ID token from Google Sign-In'),
          ),
        );
      }

      // sign in to supabase with the google id token
      await _supabaseClient.auth.signInWithIdToken(
        provider: supabase.OAuthProvider.google,
        idToken: idToken,
      );

      return const Right(unit);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }
}
