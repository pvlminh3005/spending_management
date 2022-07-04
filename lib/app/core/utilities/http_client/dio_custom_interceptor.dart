import 'package:dio/dio.dart';

import '../app_utils.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppUtils.log('REQUEST[${options.method}] => PATH: ${options.uri}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final uri = response.requestOptions.uri;
    AppUtils.log('RESPONSE[${response.statusCode}] => PATH: $uri');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final uri = err.requestOptions.uri;
    AppUtils.log('ERROR[${err.response?.statusCode}] => PATH: $uri');
    return super.onError(err, handler);
  }
}
