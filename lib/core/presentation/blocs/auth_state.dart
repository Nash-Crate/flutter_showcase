part of 'auth_cubit.dart';

/// State class for authentication.
@freezed
abstract class AuthState with _$AuthState {
  /// Processing state
  const factory AuthState.processing() = Processing;

  /// Authenticated state
  const factory AuthState.authenticated({UserProfile? userProfile}) = Authenticated;

  /// Unauthenticated state
  const factory AuthState.unauthenticated() = Unauthenticated;
}
