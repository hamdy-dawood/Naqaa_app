import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveUserID(String userID) async {
    return await prefs.setString("userID", userID);
  }

  static String getUserID() {
    return prefs.getString("userID") ?? "";
  }

  static Future<bool> removeUserID() async {
    return await prefs.remove("userID");
  }

  static Future<bool> clear() {
    return prefs.clear();
  }
}
