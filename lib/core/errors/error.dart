import 'package:flutter_showcase/core/core.dart';

/// Centralized [UnexpectedValueError] class
class UnexpectedValueError<T> extends Error {
  /// [UnexpectedValueError] constructor
  UnexpectedValueError(this.valueFailure);

  /// [valueFailure]
  final ValueFailure<T> valueFailure;

  @override
  String toString() {
    const explanation = 'Encountered a ValueFailure at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation Failure was : $valueFailure');
  }
}

/// Centralized [ConnectionFailureError] class
class ConnectionFailureError extends Error {
  @override
  String toString() => 'Failed to connect to the server';
}
