import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setString({
    required String key,
    required dynamic value,
  }) async {
    return await sharedPreferences!.setString(
      key,
      value,
    );
  }

  static String? getString({
    required String key,
  }) {
    return sharedPreferences!.getString(
      key,
    );
  }

  static Future<bool> setBoolean({
    required String key,
    required dynamic value,
  }) async {
    return await sharedPreferences!.setBool(
      key,
      value,
    );
  }

  static bool? getBoolean({
    required String key,
  }) {
    return sharedPreferences!.getBool(
      key,
    );
  }

  static Future<bool> setInt({
    required String key,
    required dynamic value,
  }) async {
    return await sharedPreferences!.setInt(
      key,
      value,
    );
  }

    static int? getInt({
    required String key,
  }) {
    return sharedPreferences!.getInt(
      key,
    );
  }

  static Future<bool> setDouble({
    required String key,
    required dynamic value,
  }) async {
    return await sharedPreferences!.setDouble(
      key,
      value,
    );
  }

    static double? getDouble({
    required String key,
  }) {
    return sharedPreferences!.getDouble(
      key,
    );
  }

  // static Future<bool> putData({
  //   required String key,
  //   required dynamic value,
  // }) async {
  //   if (value is String) return await sharedPreferences!.setString(key, value);
  //   else if (value is bool) return await sharedPreferences!.setBool(key, value);
  //   else if (value is int) return await sharedPreferences!.setInt(key, value);

  //   return await sharedPreferences!.setDouble(key, value);
  // }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences!.remove(key);
  }
}
