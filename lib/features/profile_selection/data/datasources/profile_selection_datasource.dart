import 'dart:convert';

import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/profile_selection/profile_selection.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// Data source for managing user profile selection
abstract class ProfileSelectionDataSource with IProfileSelectionRepository {}

/// Implementation of [ProfileSelectionDataSource]
@Singleton(as: ProfileSelectionDataSource)
class ProfileSelectionDataSourceImpl implements ProfileSelectionDataSource {
  /// Constructor
  const ProfileSelectionDataSourceImpl(this._supabaseClient, this._cacheStorage);

  final supabase.SupabaseClient _supabaseClient;
  final ICacheStorage _cacheStorage;

  @override
  AsyncFailT<List<UserProfile>> getUserProfiles() async {
    try {
      // get the auth id of the current user
      final authId = _supabaseClient.auth.currentUser?.id;
      if (authId == null) {
        return const Left(
          Failure.unexpectedError('User is not authenticated. Failed to get user profiles.'),
        );
      }

      // get the user profile from the database using the auth id and profile id
      final userProfilesJson = await _supabaseClient
          .from('user_profiles')
          .select()
          .eq('auth_id', authId);
      if (userProfilesJson.isEmpty) {
        return const Left(Failure.unexpectedError('No Profiles found.'));
      }

      final profiles = userProfilesJson
          .map((json) => UserProfileModel.fromJson(json).toDomain())
          .toList();
      return Right(profiles);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }

  @override
  AsyncFailT<Unit> setLastUsedUserProfile(UserProfile profile) async {
    try {
      // save the last used profile id to cache
      await _cacheStorage.upsert<String>(
        key: AuthCacheKeys.userProfileId,
        data: jsonEncode(UserProfileModel.fromDomain(profile).toJson()),
      );

      return const Right(unit);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }
}
