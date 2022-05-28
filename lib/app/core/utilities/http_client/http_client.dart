import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

import 'dio_custom_interceptor.dart';

enum ApiMethod { get, post, put, delete, patch, head }

class ApiClient {
  factory ApiClient() => _instance;
  ApiClient._internal();
  static final ApiClient _instance = ApiClient._internal();

  static String? authentication;
  static const int connectTimeOut = 6 * 1000;
  static const int receiveTimeOut = 6 * 1000;
  static int maxCacheAge = 7 * 24 * 60 * 60;
  static int maxCacheCount = 100;
  static const methodMap = {
    ApiMethod.get: 'get',
    ApiMethod.post: 'post',
    ApiMethod.put: 'put',
    ApiMethod.delete: 'delete',
    ApiMethod.patch: 'patch',
    ApiMethod.head: 'head'
  };
  static final _dio = Dio()
    ..options.connectTimeout = connectTimeOut
    ..options.receiveTimeout = receiveTimeOut
    ..interceptors.add(CustomInterceptors())
    ..interceptors.add(
      DioCacheManager(
        CacheConfig(
          defaultMaxAge: Duration(seconds: maxCacheAge),
          defaultMaxStale: const Duration(days: 10),
        ),
      ).interceptor,
    );

  static void openLog() => _dio.interceptors.add(LogInterceptor());

  static void setBaseUrl(String url) => _dio.options.baseUrl = url;

  static void setConnectTimeOut(int? val) {
    _dio.options.connectTimeout = val ?? 0;
  }

  static void setHeader(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }

  static Future<T> request<T>(
    String path, {
    ApiMethod method = ApiMethod.get,
    Map<String, dynamic>? params,
    String? subKey,
    data,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool forceRefresh = true,
    bool cacheEnable = false,
  }) async {
    options ??= Options(
      method: methodMap[method],
      responseType: ResponseType.json,
      contentType: 'application/x-www-form-urlencoded',
      headers: {'x-requested-with': 'XMLHttpRequest'},
      extra: {
        DIO_CACHE_KEY_FORCE_REFRESH: forceRefresh,
        DIO_CACHE_KEY_TRY_CACHE: cacheEnable,
        DIO_CACHE_KEY_PRIMARY_KEY: subKey,
      },
    );
    try {
      Response<T> response;
      response = await _dio.request(
        path,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data!;
    } on DioError catch (error) {
      throw createErrorEntity(error);
    }
  }
}

ErrorEntity createErrorEntity(DioError error) {
  switch (error.type) {
    case DioErrorType.cancel:
      return ErrorEntity(code: -1, message: 'Request cancellation');

    case DioErrorType.connectTimeout:
      return ErrorEntity(code: -1, message: 'Connection timed out');

    case DioErrorType.sendTimeout:
      return ErrorEntity(code: -1, message: 'Request timed out');

    case DioErrorType.receiveTimeout:
      return ErrorEntity(code: -1, message: 'Response timeout');

    case DioErrorType.response:
      try {
        var errCode = error.response?.statusCode;
        if (errCode == null) {
          return ErrorEntity(code: -2, message: error.message);
        }
        switch (errCode) {
          case 400:
            return ErrorEntity(code: errCode, message: 'Bad Request');

          case 401:
            return ErrorEntity(code: errCode, message: 'Unauthorized');

          case 403:
            return ErrorEntity(code: errCode, message: 'Forbidden');

          case 404:
            return ErrorEntity(code: errCode, message: 'Not Found');

          case 405:
            return ErrorEntity(code: errCode, message: 'Method Not Allowed');

          case 500:
            return ErrorEntity(code: errCode, message: 'Internal Server Error');

          case 502:
            return ErrorEntity(code: errCode, message: 'Bad Gateway');

          case 503:
            return ErrorEntity(code: errCode, message: 'Service Unavailable');

          case 505:
            return ErrorEntity(code: errCode, message: 'HTTP  Not Supported');

          default:
            return ErrorEntity(
              code: errCode,
              message: error.response?.statusMessage ?? '',
            );
        }
      } on Exception catch (error) {
        return ErrorEntity(code: -1, message: error.toString());
      }

    default:
      return ErrorEntity(code: -1, message: error.message);
  }
}

class ErrorEntity implements Exception {
  int code;
  String? message;
  ErrorEntity({required this.code, this.message});

  @override
  String toString() {
    if (message == null) return 'Exception';
    if (message!.contains('SocketException')) {
      message = 'Problem connecting to the server. Please try again.';
    }
    return "$message";
  }
}
