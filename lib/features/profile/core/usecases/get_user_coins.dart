import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/profile/profile.dart';
import 'package:injectable/injectable.dart';

/// Usecase to get the user's coins
@Deprecated('Uses WatchProfileCoins instead, which is more efficient and reactive.')
@singleton
class GetUserCoins implements UsecaseNoParams<double> {
  /// Constructor
  @Deprecated('Uses WatchProfileCoins instead, which is more efficient and reactive.')
  const GetUserCoins(this._repository);

  final IProfileRepository _repository;

  @override
  AsyncFailT<double> call() {
    return _repository.getUserCoins();
  }
}
