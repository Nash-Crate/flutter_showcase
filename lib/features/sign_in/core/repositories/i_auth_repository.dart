import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/sign_in/sign_in.dart';
import 'package:fpdart/fpdart.dart';

/// Interface for SignIn repository
mixin ISignInRepository {
  /// Sign in with email and password
  AsyncFailT<Unit> signInWithEmailAndPassword(EmailSignInDto dto);

  /// Sign in with Google
  AsyncFailT<Unit> signInWithGoogle();

  /// Check authentication status
  AsyncFailT<Unit> checkAuth();

  /// Get user profiles for the authenticated user
  AsyncFailT<List<UserProfile>> getUserProfiles();

  /// Get the last used user profile for the authenticated user
  AsyncFailT<UserProfile> getLastUsedUserProfile();

  /// Sign out
  AsyncFailT<Unit> signOut();
}
