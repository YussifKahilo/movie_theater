import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '/core/cache/cache_consumer.dart';
import '/core/cache/cache_keys.dart';

class AppInterceptors extends Interceptor {
  final CacheConsumer _cacheConsumer;
  Map<String, dynamic> headers = {
    'Accept': 'application/json',
  };

  AppInterceptors(this._cacheConsumer);
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    options.headers = headers;

    options.headers.addAll(
        {'session_id': '${_cacheConsumer.getData(key: CacheKeys.sessionId)}'});
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
