part of 'auth_cubit.dart';

/// State class for authentication.
@freezed
abstract class AuthState with _$AuthState {
  /// Processing state
  const factory AuthState.processing() = Processing;

  /// Partially authenticated state, when the user is authenticated
  /// but havent selected the profile to use yet.
  const factory AuthState.partiallyAuthenticated({
    required bool isProcessing,
    required List<UserProfile>? profiles,
  }) = PartiallyAuthenticated;

  /// Authenticated state
  const factory AuthState.authenticated(UserProfile userProfile) = Authenticated1;

  /// Unauthenticated state
  const factory AuthState.unauthenticated() = Unauthenticated;
}
