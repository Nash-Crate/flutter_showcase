part of 'sign_in_cubit.dart';

/// State class for sign-in process.
@freezed
abstract class SignInState with _$SignInState {
  /// sign-in state
  const factory SignInState({
    required EmailAddress email,
    required Password password,

    @Default(false) bool isProcessing,
    Either<Failure, Unit>? result,
  }) = _SignInState;

  /// Initial state
  factory SignInState.initial() => SignInState(email: EmailAddress(null), password: Password(null));
}
