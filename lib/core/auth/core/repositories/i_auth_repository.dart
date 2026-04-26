import 'package:flutter_showcase/core/core.dart';

/// Interface for auth repository
mixin IAuthRepository {
  /// Fetches the last used user profile from the local storage.
  AsyncFailT<UserProfile> getLastUsedUserProfile();
}
