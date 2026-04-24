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
          Failure.unexpectedError('No previously used profiles found in the device.'),
        );
      }

      final userProfileId = UserProfileModel.fromJson(
        jsonDecode(userProfileIdRes) as Map<String, dynamic>,
      ).id;

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
}
