import 'package:flutter/material.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:fpdart/fpdart.dart';

/// returns the maximum integer value dart allows
const int maxInt = (double.infinity is int) ? double.infinity as int : ~minInt;

/// returns the minimum integer value dart allows
const int minInt = (double.infinity is int) ? -double.infinity as int : (-1 << 63);

/// Extension for Nullable String
extension NullableStringFieldValidations on String? {
  /// check if string is null or empty
  bool get isValidString {
    return this == null || (this != null && this!.isNotEmpty);
  }

  /// check if string is null else have at least 3 characters
  bool get isValidNullableStringField {
    return this == null || (this != null && this!.isNotEmpty && this!.characters.length > 2);
  }

  /// Checks if the string is not null, not empty, and has more than 2 characters.
  bool get isValidStringField {
    return this != null && this!.isNotEmpty && this!.characters.length > 2;
  }

  /// Checks if the nullable string is valid by ensuring it is either null or a non-empty string.
  bool get isValidId => this?.isValidString ?? false;

  /// Check if the String has characters at least the amount given in [minChars]
  /// default [minChars] is 2
  bool isValid({int minChars = 2}) => (this?.characters.length ?? 0) >= minChars;

  /// Validate email address
  bool get isValidEmailAddress {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return this != null && emailRegex.hasMatch(this!);
  }

  /// Validate password
  bool get isValidPassword {
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
    return this != null && passwordRegex.hasMatch(this!);
  }

  /// Checks if a given string is a valid URL with a required path segment.
  ///
  /// Supports:
  /// - Full URLs with protocol (e.g., `https://example.com/upload`)
  /// - Localhost or custom domains with optional ports (e.g., `localhost:3000/upload`)
  ///
  /// Path is mandatory (e.g., `/upload`) and must contain alphanumeric characters, hyphens, or underscores.
  ///
  /// Returns `true` if the URL format is valid and includes a path.

  bool get isValidUrl {
    const urlPattern =
        r'^(https?|ftp):\/\/(localhost|([a-zA-Z0-9-]+\.)*[a-zA-Z0-9-]+)(:[0-9]{1,5})?(\/[a-zA-Z0-9-_]+)+$|^localhost(:[0-9]{1,5})?(\/[a-zA-Z0-9-_]+)+$|^([a-zA-Z0-9-]+)(:[0-9]{1,5})?(\/[a-zA-Z0-9-_]+)+$';

    final regex = RegExp(urlPattern);
    return regex.hasMatch(this ?? '');
  }
}

/// Extension for int
extension IntFieldValidations on int? {
  /// Valid years ranges between,
  /// `100 years ago from now` and `10 years from now`
  bool get isValidYear {
    return this != null &&
        this! > DateTime.now().subtract(const Duration(days: 365 * 100)).year &&
        this! < DateTime.now().add(const Duration(days: 365 * 10)).year;
  }

  /// Valid months ranges between 1 and 12
  bool get isValidMonth => this != null && this! > 0 && this! < 13;

  /// Valid id ranges between 1 and maxInt
  bool get isValidId => this != null; //&& this! > -maxInt && this! < maxInt;
}

/// Extension for nullable DateTime
extension NullableDateTimeFieldValidations on DateTime? {
  /// Validate created date
  bool get validateCreatedDate => this != null;

  /// Validate updated date
  bool get validateUpdatedDate => this != null;
}

/// Extension for double
extension RefractionValidations on double? {
  /// Validate double value
  bool get isValid => this != null && this! > -double.maxFinite && this! < double.maxFinite;

  /// Validate refraction sphere value
  bool get validateRefractionSphere =>
      this != null && this! > -double.maxFinite && this! < double.maxFinite;

  /// Validate refraction cylinder values
  bool get validateRefractionCylinder =>
      this != null && this! > -double.maxFinite && this! < double.maxFinite;

  /// Validate refraction axis value
  bool get validateRefractionAxis => this != null && 0 < this! && this! <= 180;

  /// Validate refraction va value
  bool get validateRefractionVa =>
      this != null && this! > -double.maxFinite && this! < double.maxFinite;

  /// Validate eye length
  bool get validateEyeLength =>
      this != null && this! > -double.maxFinite && this! < double.maxFinite;
}

/// Validate email address
Either<ValueFailure<String?>, String> validateEmailAddress(String? input) {
  if (input.isValidEmailAddress) {
    return Right(input!);
  } else {
    return Left(ValueFailure.invalidEmailAddress(failedValue: input));
  }
}

/// Validate password
Either<ValueFailure<String?>, String> validatePassword(
  String? input, {
  required String? confirmPassword,
}) {
  if (input.isValidPassword) {
    // only show passwordsDoNotMatch error if confirmPassword is provided
    if (confirmPassword != null && input != confirmPassword) {
      return Left(ValueFailure.passwordsDoNotMatch(failedValue: input));
    }
    return Right(input!);
  } else {
    return Left(ValueFailure.invalidPassword(failedValue: input));
  }
}

/// Validate confirm password
Either<ValueFailure<String?>, String> validateConfirmPassword(
  String? input, {
  required String? password,
}) {
  if (input.isValidPassword && input == password) {
    return Right(input!);
  } else {
    return Left(ValueFailure.passwordsDoNotMatch(failedValue: input));
  }
}
