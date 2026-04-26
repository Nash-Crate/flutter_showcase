import 'dart:io';

import 'package:flutter_showcase/core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// Abstract definitions for the Purchasess DataSource
abstract class PurchasesDataSource with IPurchasesRepository {}

/// Implementation of the PaymentsDataSource using RevenueCat
@Singleton(as: PurchasesDataSource)
class PurchasesDataSourceImpl implements PurchasesDataSource {
  /// Constructor
  const PurchasesDataSourceImpl(this._supabaseClient, this._cacheStorage);

  final supabase.SupabaseClient _supabaseClient;
  final ICacheStorage _cacheStorage;

  @override
  AsyncFailT<Unit> initializePurchasing() async {
    try {
      // Platform-specific API keys
      String apiKey;
      if (Platform.isIOS) {
        apiKey = const String.fromEnvironment('REVENUE_CAT_API_KEY_IOS');
      } else if (Platform.isAndroid) {
        apiKey = const String.fromEnvironment('REVENUE_CAT_API_KEY_ANDROID');
      } else {
        throw UnsupportedError('Platform not supported');
      }

      if (apiKey.isEmpty) {
        throw ArgumentError('RevenueCat API key is not set for the current platform');
      }

      await Purchases.configure(PurchasesConfiguration(apiKey));
      return const Right(unit);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }

  @override
  AsyncFailT<double> getUserCoins() async {
    try {
      final profileId = await _cacheStorage.read<int>(key: AuthCacheKeys.userProfileId);

      final coinsJson = await _supabaseClient
          .from('user_profiles_coins')
          .select('coins')
          .eq(
            'profile_id',
            profileId.toString(),
          )
          .single();

      return Right(coinsJson['coins'] as double);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }
}
