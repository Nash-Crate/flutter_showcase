part of 'sign_up_cubit.dart';

/// A state class that holds the state of the Sign Up page.
@freezed
abstract class SignUpState with _$SignUpState {
  /// constructor
  const factory SignUpState({
    required String name,
    required EmailAddress email,
    required Password password,
    required ConfirmPassword confirmPassword,

    @Default(false) bool isProcessing,
    Either<Failure, Unit>? result,
  }) = _SignUpState;

  /// initial state
  factory SignUpState.initial() => SignUpState(
    name: '',
    email: EmailAddress(null),
    password: Password(null),
    confirmPassword: ConfirmPassword(null, password: null),
  );
}
