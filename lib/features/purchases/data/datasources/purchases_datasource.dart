import 'dart:io';

import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/purchases/purchases.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// The purchases datasource of the app.
abstract class PurchasesDatasource with IPurchasesRepository {}

/// The implementation of [PurchasesDatasource]
@Singleton(as: PurchasesDatasource)
class PurchasesDatasourceImpl implements PurchasesDatasource {
  /// Constructor
  const PurchasesDatasourceImpl();

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
}
