import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:weather_app_assignment/src/device/flavor_config.dart';
import 'package:weather_app_assignment/src/service/intercepter_logger.dart';
import 'package:weather_app_assignment/src/shared/base/app_exception.dart';

class APIService {
  late Dio _dio;

  static final APIService _inst = APIService._internal();

  APIService._internal();

  static APIService get instance => _inst;

  factory APIService() {
    _inst._dio = Dio(BaseOptions(
        connectTimeout: const Duration(milliseconds: 60000),
        baseUrl: FlavorConfig.instance.apiUrl,
        receiveTimeout: const Duration(milliseconds: 60000),
        sendTimeout: const Duration(milliseconds: 60000)));
    _inst._dio.interceptors.add(AppInterceptorLogging());
    return _inst;
  }

  Future<Map<String, dynamic>> post(
      String path, Map<String, dynamic> payload) async {
    await _inst._dio.post(path, data: payload).then((res) {
      if (res.statusCode != null &&
          res.statusCode! >= 200 &&
          res.statusCode! < 300) {
        try {
          return res.data;
        } catch (error) {
          throw AppException('Have a error\nPlease try again');
        }
      } else if (res.statusCode == 401) {
        throw AppException('', code: 401);
      }
    });
    return {};
  }

  Future<Map<String, dynamic>> get(String path,
      {Map<String, dynamic>? payload, bool isCache = false}) async {
    var data = <String, dynamic>{};
    final res = await _inst._dio.get(path,
        queryParameters: payload,
        options: isCache == true
            ? CacheOptions(store: MemCacheStore()).toOptions()
            : null);
    if (res.statusCode != null &&
        res.statusCode! >= 200 &&
        res.statusCode! < 300) {
      return res.data;
    } else if (res.statusCode == 401) {
      throw AppException('', code: 401);
    }
    return data;
  }
}
