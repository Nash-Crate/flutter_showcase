import 'package:flutter_showcase/core/core.dart';
import 'package:fpdart/fpdart.dart';

/// Repository interface for managing user profile selection.
mixin IProfileSelectionRepository {
  /// Get user profiles for the authenticated user
  AsyncFailT<List<UserProfile>> getUserProfiles();

  /// Checks if the user is authenticated.
  AsyncFailT<Unit> setLastUsedUserProfile(UserProfile profile);
}
