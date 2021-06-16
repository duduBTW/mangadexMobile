import 'package:dio/dio.dart';
import 'package:mangadex/service/http.dart';

class UserControllerHelper {
  static Future<Response> getUserFollowedMangas(
      MangadexService http, int limit, int offset) async {
    return http.get("/user/follows/manga",
        queryParameters: {"limit": limit, "offset": offset});
  }

  static Future<String> getUserInfo(MangadexService http) async {
    try {
      var response = await http.get("/user/me");

      return response.data['data']['attributes'].username;
    } catch (e) {
      return "";
    }
  }
}
