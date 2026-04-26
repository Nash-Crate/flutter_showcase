import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'http_response_model.freezed.dart';

/// extension for 'http' status code simplifications
extension HttpResponseStatusCodeX on int? {
  /// Confirm that the status code is 200
  bool get isOk => this != null && this! == 200;

  /// Confirm that the status code is 201
  bool get isCreated => this != null && this! == 201;

  /// Confirm that the status code is 204
  bool get isNoContent => this != null && this! == 204;

  /// Confirm that the status code is 400
  bool get isBadRequest => this != null && this! == 400;
}

/// Response model for 'http' requests.
@freezed
abstract class HttpResponseModel<T> with _$HttpResponseModel<T> {
  /// constructor
  const factory HttpResponseModel({
    /// The response payload in specific type.
    ///
    /// The content could have been transformed by the ['Transformer']
    /// before it can use eventually.
    T? data,

    /// The HTTP status code for the response.
    ///
    /// This can be null if the response was constructed manually.
    int? statusCode,

    /// Returns the reason phrase associated with the status code.
    String? statusMessage,
  }) = _HttpResponseModel;

  /// Create a [HttpResponseModel] from a ['DioResponse'].
  factory HttpResponseModel.fromDioResponse(Response<T> response) {
    return HttpResponseModel(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  // /// Create a [HttpResponseModel] from a ['DioResponse'].
  // factory HttpResponseModel.fromDynamicDioResponse(Response<dynamic> response) {
  //   return HttpResponseModel(
  //     data: {'data': response.data},
  //     statusCode: response.statusCode,
  //     statusMessage: response.statusMessage,
  //   );
  // }
}
