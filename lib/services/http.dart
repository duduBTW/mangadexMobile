import 'package:dio/dio.dart';

const String _baseUrl = "https://api.mangadex.org/";

class MangadexService {
  late Dio _dio;

  MangadexService() {
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));

    // _dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) {
    //     return handler
    //         .resolve(Response(requestOptions: options, data: 'fake data'));
    //   },
    // ));
  }

  initializeInterceptions() {
    _dio.interceptors
        .add(InterceptorsWrapper(onError: (error, errorInterceptorHandler) {
      print(error.message);
    }, onRequest: (request, requestInterceptorHandler) {
      print("${request.method} | ${request.baseUrl}");
    }, onResponse: (response, responseInterceptorHandler) {
      print(
          '${response.statusCode} | ${response.statusCode} | ${response.data}');
    }));
  }

  Future<Response> get(String endpoint) async {
    return await _dio.get(endpoint);
  }

  Future<Response> post(String endpoint, dynamic data) async {
    return await _dio.post(endpoint, data: data);
  }
}
