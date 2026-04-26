import 'package:flutter_showcase/core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// The implementation of [IPurchasesRepository]
@Singleton(as: IPurchasesRepository)
class PurchasesRepository implements IPurchasesRepository {
  /// constructor
  const PurchasesRepository(this._dataSource);

  final PurchasesDataSource _dataSource;

  @override
  AsyncFailT<Unit> initializePurchasing() {
    return _dataSource.initializePurchasing();
  }

  @override
  AsyncFailT<double> getUserCoins() {
    return _dataSource.getUserCoins();
  }
}
