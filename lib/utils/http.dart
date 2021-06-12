import 'package:dio/dio.dart';

const String _baseUrl = "https://api.mangadex.org/";

class MangadexService {
  late Dio _dio;

  MangadexService() {
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
    setInterceptors();
  }

  void setInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      print('REQUEST[${options.method}] => PATH: ${options.path}');
      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onResponse: (response, handler) {
      print('RESPONSE[${response.statusCode}]');
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onError: (DioError e, handler) {
      print('ERROR[${e.response?.statusCode}] ');
      // Do something with response error
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));
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
