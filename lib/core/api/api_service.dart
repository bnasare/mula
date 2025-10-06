import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        // baseUrl: EndPoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        validateStatus: (status) => status != null && status < 500,
        headers: {'Accept': 'application/json'},
      ),
    );

    // Add interceptors
    _dio.interceptors.add(_createAuthInterceptor());

    if (kDebugMode) {
      _dio.interceptors.add(_createLoggingInterceptor());
    }
  }

  /// Creates auth interceptor that adds authentication headers to requests
  InterceptorsWrapper _createAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        // Only add default auth headers if no auth headers are already present
        // This prevents conflicts when methods explicitly provide auth headers
        if (!options.headers.containsKey('x-api-key') ||
            !options.headers.containsKey('x-timestamp') ||
            !options.headers.containsKey('x-signature')) {
          // final authHeaders = ApiAuthService.getAuthHeaders();
          // options.headers.addAll(authHeaders);
        }
        handler.next(options);
      },
      onError: (error, handler) {
        // Handle authentication errors
        if (error.response?.statusCode == 401) {
          // Token expired or invalid - could trigger logout here
          log('Authentication error: ${error.response?.statusCode}');
        }
        handler.next(error);
      },
    );
  }

  /// Creates logging interceptor for debug builds
  InterceptorsWrapper _createLoggingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        log('=== REQUEST ===');
        log('${options.method} ${options.uri}');
        log('Headers: ${options.headers}');
        if (options.data != null) {
          log('Body: ${options.data}');
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        log('=== RESPONSE ===');
        log('Status: ${response.statusCode}');
        log('Headers: ${response.headers}');
        log('Body: ${response.data}');
        handler.next(response);
      },
      onError: (error, handler) {
        log('=== ERROR ===');
        log('Status: ${error.response?.statusCode}');
        log('Message: ${error.message}');
        log('Data: ${error.response?.data}');
        handler.next(error);
      },
    );
  }

  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// PATCH request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Downloads a file
  Future<Response> download(
    String urlPath,
    dynamic savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Options? options,
  }) async {
    return await _dio.download(
      urlPath,
      savePath,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      deleteOnError: deleteOnError,
      lengthHeader: lengthHeader,
      options: options,
    );
  }

  /// Get the underlying Dio instance for advanced usage
  Dio get dio => _dio;
}
