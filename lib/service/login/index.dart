import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../http.dart';
import 'model/index.dart';

class LoginController with ChangeNotifier {
  late final MangadexService http;
  static final storage = new FlutterSecureStorage();

  bool _loggedIn = false;
  bool _loading = false;
  bool get loggedIn => _loggedIn;
  bool get loading => _loading;

  LoginController(MangadexService http) {
    this.http = http;

    validateLogin();
  }

  void logIn(String username, String password) {
    loading = true;

    http.post("/auth/login", {"username": username, "password": password}).then(
        (response) async {
      if (response.statusCode == 200) {
        var token = LoginModel.fromJson(response.data).token;

        //Success
        http.setAuth(token.session);
        _loggedIn = true;
        _loading = false;

        await setToken(token.session, token.refresh);

        notifyListeners();
        return;
      }

      loading = false;
    }).catchError((err) {
      loading = false;
    });
  }

  Future<void> logOut() async {
    _loggedIn = false;
    http.logOut();
    await removeTokenLocal();
    notifyListeners();

    return;
  }

  set loading(bool newValue) {
    _loading = newValue;
    notifyListeners();
  }

  void validateLogin() async {
    String? token = await getToken();

    if (token != null && token.isNotEmpty) {
      _loggedIn = true;
      http.setAuth(token);

      notifyListeners();
    }
  }

  static setToken(String token, String refreshToken) async {
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'refreshToken', value: refreshToken);
  }

  static removeTokenLocal() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'refreshToken');
  }

  static Future<String?> getToken() async {
    return storage.read(key: 'token');
  }

  // static removeToken() async {
  //   await SESSION.prefs.clear();
  // }
}
