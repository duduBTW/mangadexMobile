import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mangadex/service/user/index.dart';

import '../http.dart';
import 'model/index.dart';

class LoginController with ChangeNotifier {
  late final MangadexService http;
  static final storage = new FlutterSecureStorage();
  String? _username;

  String? get username => _username;

  set username(String? username) {
    _username = username;
    notifyListeners();
  }

  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  bool _loading = false;
  bool get loading => _loading;

  set loggedIn(bool loggedInNew) {
    _loggedIn = loggedInNew;
    notifyListeners();

    if (loggedInNew) {
      UserControllerHelper.getUserInfo(http)
          .then((userNameNew) => username = userNameNew);
    } else {
      username = null;
    }
  }

  LoginController(MangadexService http) {
    this.http = http;
    validateLogin();
  }

  void logIn(String username, String password) {
    loading = true;
    Dio _dio = new Dio();

    _dio.post("${MangadexService.baseUrl}auth/login", data: {
      "username": username,
      "password": password
    }).then((response) async {
      if (response.statusCode == 200) {
        var token = LoginModel.fromJson(response.data).token;

        //Success
        http.setAuth(token.session);
        loggedIn = true;
        _loading = false;

        await LoginControllerHelper.setToken(token.session, token.refresh);

        notifyListeners();
        return;
      }

      loading = false;
    }).catchError((err) {
      print(err);
      loading = false;
    });
  }

  Future<void> logOut() async {
    _loggedIn = false;
    http.logOut();
    await LoginControllerHelper.removeTokenLocal();
    notifyListeners();

    return;
  }

  set loading(bool newValue) {
    _loading = newValue;
    notifyListeners();
  }

  void validateLogin() async {
    String? token = await LoginControllerHelper.getToken();

    if (token != null && token.isNotEmpty) {
      _loggedIn = true;
      http.setAuth(token);

      notifyListeners();
    }
  }

  // static removeToken() async {
  //   await SESSION.prefs.clear();
  // }
}

class LoginControllerHelper {
  static final storage = new FlutterSecureStorage();

  static Future<String> revalidateToken(MangadexService http) async {
    print("Revalidating");

    var revalidate = await storage.read(key: 'refreshToken');

    if (revalidate == null) {
      return "";
    }

    try {
      Dio _dio = new Dio();
      var response = await _dio.post("${MangadexService.baseUrl}auth/refresh",
          data: {"token": revalidate});

      print(response.data.toString());
      if (response.statusCode == 200) {
        var token = LoginModel.fromJson(response.data).token;

        //Success
        http.setAuth(token.session);

        await setToken(token.session, token.refresh);
        print("token.session: ${token.session}");
        return token.session;
      }
    } catch (e) {
      print("Fail");
      print(e);
    }

    return "";
  }

  static setToken(String token, String refreshToken) async {
    var valid = new DateTime.now().add(Duration(minutes: 15));
    MangadexService.validUntil = valid;
    await storage.write(key: 'validUntil', value: valid.toString());
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
}
