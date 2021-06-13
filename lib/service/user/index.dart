import 'package:dio/dio.dart';
import 'package:mangadex/service/http.dart';

class UserController {
  static MangadexService http = new MangadexService();

  static Future<Response> getUserFollowedMangas(int limit, int offset) async {
    return http.get("/user/follows/manga",
        queryParameters: {"limit": limit, "offset": offset});
  }
}
