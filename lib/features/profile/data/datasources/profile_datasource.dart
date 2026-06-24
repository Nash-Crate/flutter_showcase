import 'dart:async';

import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/profile/profile.dart';
import 'package:flutter_showcase/logger.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// Datasource for posts
abstract class ProfileDatasource with IProfileRepository {}

/// Implementation of [ProfileDatasource]
@Singleton(as: ProfileDatasource)
class ProfileDatasourceImpl implements ProfileDatasource {
  /// Constructor
  const ProfileDatasourceImpl(this._supabaseClient, this._cacheStorage);

  final supabase.SupabaseClient _supabaseClient;
  final ICacheStorage _cacheStorage;

  @override
  StreamFailT<double> fetchProfileCoins() async* {
    final profileId = await _cacheStorage.read<int>(key: AuthCacheKeys.userProfileId);
    if (profileId == null) {
      yield const Left(Failure.custom('User profile ID not found in cache.'));
      return;
    }

    yield* _supabaseClient
        .from('user_profiles_coins')
        .stream(primaryKey: ['id'])
        .eq('profile_id', profileId)
        .map<Either<Failure, double>>(
          (rows) => Right(rows.isEmpty ? 0.0 : (rows.first['coins'] as num).toDouble()),
        )
        .handleError((Object e) {
          // optional: log here
        })
        .transform(
          StreamTransformer<Either<Failure, double>, Either<Failure, double>>.fromHandlers(
            handleError: (e, st, sink) => sink.add(Left(InfraExceptions.exceptionToFailure(e))),
          ),
        );
  }
}
