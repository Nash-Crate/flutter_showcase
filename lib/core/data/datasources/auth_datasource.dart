import 'dart:convert';

import 'package:flutter_showcase/core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// Data source for authentication, implements the [IAuthRepository] interface.
abstract class AuthDatasource with IAuthRepository {}

/// Implementation of the [AuthDatasource] interface.
@Singleton(as: AuthDatasource)
class AuthDatasourceImpl implements AuthDatasource {
  /// Constructor for the [AuthDatasourceImpl] class.
  const AuthDatasourceImpl(this._supabaseClient, this._cacheStorage);

  final supabase.SupabaseClient _supabaseClient;
  final ICacheStorage _cacheStorage;

  @override
  AsyncFailT<bool> checkAuth() async {
    try {
      final cachedSessionRes = await _cacheStorage.read<String>(key: AuthCacheKeys.userSession);
      // if there is no cached session, return unauthenticated
      if (cachedSessionRes == null) return const Right(false);

      final sessionRes = jsonDecode(cachedSessionRes);
      // TODO(fix): add a json encode model
      await _supabaseClient.auth.setSession(sessionRes['refresh_token']! as String);

      // refresh the session to get the latest session data and validate the session
      final newSession = await _supabaseClient.auth.refreshSession();
      final sessionString = jsonEncode(newSession.session);
      await _cacheStorage.upsert<String>(key: AuthCacheKeys.userSession, data: sessionString);

      final userId = _supabaseClient.auth.currentUser?.id;
      if (userId == null) {
        return const Left(Failure.unexpectedError('Failed to get user id from session'));
      }

      return const Right(true);
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
      final userProfileId = await _cacheStorage.read<int>(key: AuthCacheKeys.userProfileId);
      if (userProfileId == null) {
        return const Left(
          Failure.unexpectedError('No previously used profiles found in the device.'),
        );
      }

      // get the user profile from the database using the auth id and profile id
      final userProfileJson = await _supabaseClient
          .from('user_profiles')
          .select()
          .eq('auth_id', authId)
          .eq('id', userProfileId)
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

  @override
  AsyncFailT<Unit> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
      await _cacheStorage.clear();

      return const Right(unit);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }
}
