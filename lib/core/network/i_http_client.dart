import 'package:dio/dio.dart';
import 'package:flutter_showcase/core/network/network.dart';

/// Request content type
enum RequestContentType {
  /// application/json
  json,

  /// application/x-www-form-urlencoded
  formEncoded,

  /// multipart/form-data
  formData,
}

/// Http client interface
abstract class IHttpClient {
  /// Http method for [get] requests
  Future<HttpResponseModel<T>> get<T>(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  });

  /// Http method for [post] requests
  Future<HttpResponseModel<T>> post<T>(
    String uri, {
    Map<String, dynamic>? data,
    RequestContentType requestType = RequestContentType.json,
    Map<String, dynamic>? queryParameters,
  });

  /// Http method for [patch] requests
  Future<HttpResponseModel<T>> patch<T>(
    String uri, {
    required Object data,
    Map<String, dynamic>? queryParameters,
  });

  /// Http method for [put] requests
  Future<HttpResponseModel<T>> put<T>(
    String uri, {
    required Object data,
    Map<String, dynamic>? queryParameters,
  });

  /// Http method for [delete] requests
  Future<HttpResponseModel<T>> delete<T>(String uri, {Map<String, dynamic>? queryParameters});
}
