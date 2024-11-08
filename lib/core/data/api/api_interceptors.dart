import 'package:dio/dio.dart';
import 'package:mandopy/core/data/cached/cache_helper.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[''] = CacheHelper.getData(key: '') != null
        ? "${CacheHelper.getData(key: "")}"
        : null;
    super.onRequest(options, handler);
  }
}
