import 'package:dio/dio.dart';

const String _baseUrl = "https://api.mangadex.org/";

class MangadexService {
  late Dio _dio;

  MangadexService() {
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));

    // _dio.interceptors.add(InterceptorsWrapper(
    //     onRequest: (request, requestInterceptorHandler) => request,
    //     onResponse: (response, requestInterceptorHandler) => response,
    //     onError: (error, requestInterceptorHandler) => error));
  }

  Future<Response> get(String endpoint) async {
    return await _dio.get(endpoint);
  }

  Future<Response> post(String endpoint, dynamic data) async {
    return await _dio.post(endpoint, data: data);
  }

  void setAuth(String token) {
    _dio.options.headers["Authorization"] = "Bearer $token";
  }
}
