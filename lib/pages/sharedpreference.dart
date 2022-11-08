import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static  SharedPreferences? _preferences;

  static const _keyUsername = 'username';
  static const _islogin = 'login';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future saveUser(String name) async {
    log("name ===="+name);
    await _preferences?.setString(_keyUsername, name);
    await _preferences?.setBool(_islogin, true);
  }

  static Future logout() async {
    await _preferences?.setString(_keyUsername, '');
    await _preferences?.setBool(_islogin, false);
  }

   static  String? getUsername() {
    if (_preferences == null) {
      init();
    }
    return _preferences?.getString(_keyUsername);
  }

  static bool? getlogindata() {
    if (_preferences == null) {
      init();
    }
    return _preferences?.getBool(_islogin);
  }
}