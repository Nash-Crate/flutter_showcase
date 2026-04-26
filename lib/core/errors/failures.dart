import 'package:flutter_showcase/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Base class for all [Failure]s
@freezed
class Failure with _$Failure {
  /// Format Exceptions thrown by [dart:convert]
  const factory Failure.formatException(String message) = _FormatException;

  /// Unable to process the request
  const factory Failure.unableToProcess(String error) = _UnableToProcess;

  /// Unexpected error
  const factory Failure.unexpectedError(String message) = _UnexpectedError;

  /// Authentication failures
  const factory Failure.authFailure(AuthFailure f) = _AuthFailure;

  /// Network failures
  const factory Failure.networkFailure(NetworkFailure f) = _NetworkFailure;

  /// Cache failures
  const factory Failure.cacheFailure(CacheFailure f) = _CacheFailure;

  /// Custom failure with a message
  const factory Failure.custom(String message) = _CustomFailure;
}
