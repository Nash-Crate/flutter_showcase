import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/profile/profile.dart';

import 'package:injectable/injectable.dart';

/// Usecase class for fetching and streaming the profile coins.
@singleton
class WatchProfileCoins implements UsecaseStreamNoParams<double> {
  /// Constructor
  const WatchProfileCoins(this._repository);

  final IProfileRepository _repository;

  @override
  StreamFailT<double> call() {
    return _repository.watchProfileCoins();
  }
}
