part of 'infra_exceptions.dart';

/// Dio Exceptions
enum DioUnknownErrorEnum {
  /// if no previous auth exists
  noPreviousAuth,

  /// when the session is expired
  sessionExpired,
}

Failure _getDioException(DioException error) {
  late Failure failure;

  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      failure = const Failure.networkFailure(RequestTimeout());
    case DioExceptionType.badCertificate:
      failure = const Failure.networkFailure(BadCertificate());
    case DioExceptionType.badResponse:
      // 400 error
      final data = error.response?.data;
      var errorMessage = '';
      // check if contains a error message
      if (data is Map<String, dynamic>) {
        if (data.containsKey('message')) {
          errorMessage = data['message'].toString();
        } else if (data.containsKey('error_description')) {
          errorMessage = data['error_description'].toString();
        }
      }
      if (errorMessage.contains('Token is not active')) {
        failure = const Failure.authFailure(TokenExpired());
      } else {
        failure = Failure.networkFailure(BadResponse(errorMessage));
      }
    case DioExceptionType.cancel:
      failure = const Failure.networkFailure(RequestCancelled());
    case DioExceptionType.connectionError:
      failure = const Failure.networkFailure(ConnectionError());
    case DioExceptionType.unknown:
      {
        if (error.error == DioUnknownErrorEnum.sessionExpired) {
          failure = const Failure.authFailure(TokenExpired());
          break;
        } else if (error.error == DioUnknownErrorEnum.noPreviousAuth) {
          failure = const Failure.authFailure(NoPreviousAuth());
          break;
        } else if (error.response?.statusCode == null) {
          failure = const Failure.networkFailure(UnexpectedError('somethingWentWrong'));
          break;
        }

        switch (error.response!.statusCode) {
          case 400:
            failure = Failure.networkFailure(BadResponse(error.response!.data.toString()));
          case 401:
            failure = Failure.networkFailure(UnauthorisedRequest(error.response!.data.toString()));
          case 403:
            failure = Failure.networkFailure(UnauthorisedRequest(error.response!.data.toString()));
          case 404:
            failure = Failure.networkFailure(NotFound(error));
          case 409:
            failure = const Failure.networkFailure(Conflict());
          case 408:
            failure = const Failure.networkFailure(RequestTimeout());
          case 500:
            failure = const Failure.networkFailure(InternalServerError());
          case 503:
            failure = const Failure.networkFailure(ServiceUnavailable());
          default:
            final responseCode = error.response?.statusCode;
            failure = Failure.networkFailure(
              DefaultError('Received invalid status code: $responseCode'),
            );
        }
      }
  }

  return failure;
}
