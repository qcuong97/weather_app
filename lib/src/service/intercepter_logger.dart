import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppInterceptorLogging extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!kReleaseMode) {
      log('*** Request ***\nREQUEST[${options.method}] => ${options.uri}');
      if (options.data != null) {
        log('*** PARAMS ***\n${options.data}');
      }
      log('*** HEADERS ***\n${options.headers}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!kReleaseMode) {
      try {
        log(
          '*** Response ***\nRESPONSE[${response.statusCode}] => ${response.realUri}\n${jsonEncode(response.data)}',
        );
      } catch (_) {}
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!kReleaseMode) {
      log(
        '*** Error ***\nERROR[${err.response?.data?['code'] ?? err.response?.statusCode}] => ${err.requestOptions.uri} WITH MESSAGE: ${err.response?.data?['message'] ?? err.response?.data?['detail'] ?? err.message}',
      );
    }
    handler.next(err);
  }
}
