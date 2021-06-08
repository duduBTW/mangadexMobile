import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController {
  static final storage = new FlutterSecureStorage();

  static setToken(String token, String refreshToken) async {
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'refreshToken', value: refreshToken);
  }

  static Future<String?> getToken() async {
    return storage.read(key: 'token');
  }

  // static removeToken() async {
  //   await SESSION.prefs.clear();
  // }
}
