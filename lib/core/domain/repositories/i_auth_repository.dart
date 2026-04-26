import 'package:flutter_showcase/core/core.dart';
import 'package:fpdart/fpdart.dart';

/// Interface for auth repository
mixin IAuthRepository {
  /// Check authentication status
  AsyncFailT<bool> checkAuth();

  /// Fetches the last used user profile from the local storage.
  AsyncFailT<UserProfile> getLastUsedUserProfile();

  /// Sign out
  AsyncFailT<Unit> signOut();
}
