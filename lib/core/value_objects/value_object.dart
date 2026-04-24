import 'package:flutter/foundation.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:fpdart/fpdart.dart';

/// Extension for ValueObject
extension NullableVO<T> on ValueObject<T>? {
  /// check isValid when the value is null
  bool get isNullableValid => this == null || (this!.isValid);

  /// check isValid when the value is null or empty string('')
  bool get isEmptyValid =>
      this != null &&
      this!.value.fold(
        (l) => l.failedValue is String && (l.failedValue! as String).isEmpty,
        (r) => true,
      );

  /// check isValid when the value is NotNull
  bool get isValid => this != null && this!.isValid;

  /// check if has no value or null
  bool get hasNoValue =>
      this?.value.fold(
        (l) =>
            l.failedValue == null ||
            (l.failedValue is String && (l.failedValue! as String).isEmpty),
        (r) => false,
      ) ??
      true;
}

/// ValueObject abstract class
@immutable
abstract class ValueObject<T> {
  /// ValueObject constructor
  const ValueObject();

  /// ValueObject value getter
  Either<ValueFailure<T?>, T> get value;

  /// Returns true if the value is valid
  bool get isValid => value.isRight();

  /// Returns the value if the value is valid
  ///
  /// Throws [UnexpectedValueError] if the value contains a [ValueFailure]
  T get getOrCrash => value.fold((f) => throw UnexpectedValueError(f), (r) => r);

  /// Returns the value if the value is valid
  T? get getOrNull => value.fold((f) => null, (r) => r);

  /// Returns the value if the value is valid
  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    return value.fold(Left.new, (r) => const Right(unit));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value.toString();
}
