import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_failures.freezed.dart';

/// Base class for all [ValueFailure]s
@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  // common
  /// Invalid String id
  const factory ValueFailure.invalidStringId({required T failedValue}) = InvalidStringId;

  /// Invalid int id
  const factory ValueFailure.invalidIntId({required T failedValue}) = InvalidIntId;

  /// Invalid full phone number
  const factory ValueFailure.invalidFullPhoneNumber({required T failedValue}) =
      InvalidFullPhoneNumber;

  /// Invalid phone number
  const factory ValueFailure.invalidPhoneNumber({required T failedValue}) = InvalidPhoneNumber;

  /// Invalid country calling code
  const factory ValueFailure.invalidCountryCallingCode({required T failedValue}) =
      InvalidCountryCallingCode;

  /// Invalid verification code
  const factory ValueFailure.invalidVerificationCode({required T failedValue}) =
      InvalidVerificationCode;

  /// Invalid string field
  const factory ValueFailure.invalidStringField({required T failedValue}) = InvalidStringField;

  /// Email failures
  const factory ValueFailure.invalidEmailAddress({required T failedValue}) = InvalidEmailAddress;

  /// Password failures
  const factory ValueFailure.invalidPassword({required T failedValue}) = InvalidPassword;

  /// Confirm password failures
  const factory ValueFailure.passwordsDoNotMatch({required T failedValue}) = PasswordsDoNotMatch;
}
