import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_failure.freezed.dart';

/// Base class for all [NetworkFailure]s
@freezed
class NetworkFailure with _$NetworkFailure {
  /// Request cancelled
  const factory NetworkFailure.requestCancelled() = RequestCancelled;

  /// Unauthorised request
  const factory NetworkFailure.unauthorisedRequest(String? errorMessage) = UnauthorisedRequest;

  /// Bad request
  const factory NetworkFailure.badCertificate() = BadCertificate;

  /// Bad request
  const factory NetworkFailure.badRequest() = BadRequest;

  /// Bad response
  const factory NetworkFailure.badResponse(String? errorMessage) = BadResponse;

  /// Connection error
  const factory NetworkFailure.connectionError() = ConnectionError;

  /// Not found
  const factory NetworkFailure.notFound(dynamic error) = NotFound;

  /// Method not allowed
  const factory NetworkFailure.methodNotAllowed() = MethodNotAllowed;

  /// Not acceptable
  const factory NetworkFailure.notAcceptable() = NotAcceptable;

  /// Request timeout
  const factory NetworkFailure.requestTimeout() = RequestTimeout;

  /// Conflict
  const factory NetworkFailure.conflict() = Conflict;

  /// Internal server error
  const factory NetworkFailure.internalServerError() = InternalServerError;

  /// Not implemented
  const factory NetworkFailure.notImplemented() = NotImplemented;

  /// Service unavailable
  const factory NetworkFailure.serviceUnavailable() = ServiceUnavailable;

  /// Connection refused
  const factory NetworkFailure.connectionRefused() = ConnectionRefused;

  /// No internet connection
  const factory NetworkFailure.noInternetConnection() = NoInternetConnection;

  /// Default error
  const factory NetworkFailure.defaultError(String error) = DefaultError;

  /// Unexpected error
  const factory NetworkFailure.unexpectedError(dynamic data) = UnexpectedError;
}
