import 'package:flutter_showcase/core/core.dart';

/// abstract repository for profile actions
mixin IProfileRepository {
  /// Fetches the user's coins.
  AsyncFailT<double> getUserCoins();

  /// Fetch and watch the number of coins for the active user profile
  StreamFailT<double> watchProfileCoins();
}
