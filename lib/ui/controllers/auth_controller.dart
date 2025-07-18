import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user_model.dart';

class authcontroller {
  static user? userModel;
  static String? accessToken;

  static Future<void> saveUserData(String token, user userModels) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('user', jsonEncode(userModels.toJson()));
    accessToken = token;
    userModel = userModels;
  }

  static Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userModel = user.fromjson(jsonDecode(prefs.getString('user')!));
    accessToken = prefs.getString('token');
    //return prefs.getString('token');
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      await getUserData();
      return true;
    }
    return false;
  }

  static Future<void> removeUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
