import 'package:flutter/material.dart';

class UserLogin with ChangeNotifier {
  late String _token;

  String get token => _token;
}
