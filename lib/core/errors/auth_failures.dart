import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failures.freezed.dart';

/// Base class for all [AuthFailure]s
@freezed
class AuthFailure with _$AuthFailure {
  /// General authentication failure
  const factory AuthFailure.failed({String? message}) = Failed;

  /// No previous authentications
  const factory AuthFailure.noPreviousAuth() = NoPreviousAuth;

  /// Authentication token expired
  const factory AuthFailure.tokenExpired() = TokenExpired;

  // const factory AuthFailure.emailVerificationFailed() = EmailVerificationFailed;
  // const factory AuthFailure.passwordResetFailed() = PasswordResetFailed;

  /// Authentication validation failed
  const factory AuthFailure.validationFailed(String error) = ValidationFailed;
}
