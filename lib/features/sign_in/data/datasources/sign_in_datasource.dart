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

  @override
  AsyncFailT<List<UserProfile>> getUserProfiles() async {
    try {
      final userId = _supabaseClient.auth.currentUser?.id;
      if (userId == null) {
        return const Left(Failure.unexpectedError('Failed to get Profiles for the user'));
      }

      final userProfilesJson = await _supabaseClient.from('user_profiles').select();
      if (userProfilesJson.isEmpty) {
        return const Left(Failure.unexpectedError('Failed to fetch user profiles from database'));
      }

      final profiles = (userProfilesJson as List)
          .map((json) => UserProfileModel.fromJson(json as Map<String, dynamic>).toDomain())
          .toList();
      return Right(profiles);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }

  @override
  AsyncFailT<UserProfile> getLastUsedUserProfile() async {
    try {
      // get the auth id of the current user
      final authId = _supabaseClient.auth.currentUser?.id;
      if (authId == null) {
        return const Left(
          Failure.unexpectedError('User is not authenticated. Failed to get user profile.'),
        );
      }

      // get the last used profile id from cache
      final userProfileIdRes = await _cacheStorage.read<String>(key: AuthCacheKeys.userProfileId);
      if (userProfileIdRes == null) {
        return const Left(
          Failure.unexpectedError('No preivously used profiles found in the device.'),
        );
      }

      // get the user profile from the database using the auth id and profile id
      final userProfileJson = await _supabaseClient
          .from('user_profiles')
          .select()
          .eq('auth_id', authId)
          .eq('id', userProfileIdRes)
          .maybeSingle();
      if (userProfileJson == null) {
        return const Left(Failure.unexpectedError('Last used profile not found.'));
      }

      final profile = UserProfileModel.fromJson(userProfileJson).toDomain();
      return Right(profile);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }
}
