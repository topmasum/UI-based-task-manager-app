import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user_model.dart';

class authcontroller {
  static user? userModel;
  static String? accessToken;
  static String _userKey='user';
  static String _tokenKey='token';

  static Future<void> saveUserData(String token, user userModels) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userKey, jsonEncode(userModels.toJson()));
    accessToken = token;
    userModel = userModels;
  }
  static Future<void> UpdateUserData(user userModels) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(userModels.toJson()));
    userModel = userModels;
  }

  static Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userModel = user.fromjson(jsonDecode(prefs.getString(_userKey)!));
    accessToken = prefs.getString(_tokenKey);
    //return prefs.getString('token');
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_tokenKey);
    if (token != null) {
      await getUserData();
      return true;
    }
    return false;
  }

  static Future<void> removeUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    userModel = null;
    accessToken = null;
  }
}
