import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences? sharedPreferences;

  static int() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static dynamic getData({
    required String key
  }) {
    return sharedPreferences!.get(key);
  }
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if(value is String)return await sharedPreferences!.setString(key, value);
    if(value is double)return await sharedPreferences!.setDouble(key, value);
    if(value is bool)return await sharedPreferences!.setBool(key, value);
    return await sharedPreferences!.setInt(key, value);
  }
  static Future<bool> clearData({required String key,})async{
    return await sharedPreferences!.remove(key);
  }
}