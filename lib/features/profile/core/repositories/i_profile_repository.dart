import 'package:flutter_showcase/core/core.dart';

/// abstract repository for profile actions
mixin IProfileRepository {
  /// Fetch the number of coins for the active user profile
  StreamFailT<double> fetchProfileCoins();
}
