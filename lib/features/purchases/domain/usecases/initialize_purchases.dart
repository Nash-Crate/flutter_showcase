import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/purchases/purchases.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Initializes the purchases
@singleton
class InitializePurchases implements UsecaseNoParams<Unit> {
  /// constructor
  const InitializePurchases(this._repository);

  final IPurchasesRepository _repository;

  @override
  AsyncFailT<Unit> call() {
    return _repository.initializePurchasing();
  }
}
