import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mangadex/service/login/index.dart';

class MangadexService {
  static const String baseUrl = "https://api.mangadex.org/";
  late Dio _dio;
  static final storage = new FlutterSecureStorage();
  static DateTime? validUntil;

  MangadexService() {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
    setInterceptors();
    // setDefault();
  }

  void setDef() async {
    var valid = await storage.read(key: 'validUntil');
    if (valid != null) validUntil = DateTime.parse(valid);
  }

  // void setDefault() async {
  //   print("Setting header");
  //   var token = await storage.read(key: "token");
  //   setAuth(token!);
  // }

  void setInterceptors() {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      // Do something before request is sent
      print(
          'REQUEST[${options.method}] => PATH: ${options.path} ${options.queryParameters}');

      // print(validUntil!.isBefore(new DateTime.now()));
      // print(validUntil);
      if (validUntil == null) {
        var valid = await storage.read(key: 'validUntil');
        if (valid != null) {
          validUntil = DateTime.parse(valid);
        } else {
          return handler.next(options);
          // handler.reject(
          //     DioError(error: "validUntil not found", requestOptions: options));
        }
      }

      if (validUntil!.isBefore(new DateTime.now())) {
        options.headers.remove('Authorization');
        var token = await LoginControllerHelper.revalidateToken(this);
        print("token");
        print(token);
        var customHeaders = {
          'content-type': 'application/json',
          'Authorization': "Bearer $token"
          // other headers
        };

        options.headers.addAll(customHeaders);

        return handler.next(options);
      }

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
      print('ERROR[${e.response?.statusCode}] | ${e.response?.data}');
      // Do something with response error
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));
  }

  Future<Response<T>> get<T>(String endpoint,
      {Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      void Function(int, int)? onReceiveProgress}) async {
    return await _dio.get<T>(endpoint, queryParameters: queryParameters);
  }

  Future<Response> post(String endpoint, dynamic data) async {
    return await _dio.post(endpoint, data: data);
  }

  void setAuth(String token) {
    var customHeaders = {
      'content-type': 'application/json',
      'Authorization': "Bearer $token"
      // other headers
    };

    _dio.options.headers.addAll(customHeaders);
  }

  void logOut() {
    _dio.options.headers.remove('Authorization');
  }
}
