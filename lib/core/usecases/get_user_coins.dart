import 'package:flutter_showcase/core/core.dart';
import 'package:injectable/injectable.dart';

/// Usecase to get the user's coins
@singleton
class GetUserCoins implements UsecaseNoParams<double> {
  /// Constructor
  const GetUserCoins(this._repository);

  final IPurchasesRepository _repository;

  @override
  AsyncFailT<double> call() {
    return _repository.getUserCoins();
  }
}
