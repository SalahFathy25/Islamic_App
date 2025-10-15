import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static Future<void> initCacheHelper() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required MyCashKey key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key.name, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key.name, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key.name, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key.name, value);
    } else {
      // لو Object → حوله JSON وخزنه كـ String
      final jsonString = jsonEncode(value);
      return await sharedPreferences.setString(key.name, jsonString);
    }
  }

  static dynamic getData({required MyCashKey key}) {
    return sharedPreferences.get(key.name);
  }

  static Future<bool> removeData({required MyCashKey key}) async {
    return await sharedPreferences.remove(key.name);
  }

  //set secure String
  // static Future saveSecureData(
  //     {required MyCashKey key,   String? value}) async {
  //   const flutterSecureStorage = FlutterSecureStorage();
  //   return await flutterSecureStorage.write(key: key.name, value: value);
  // }

  // read secure String
  // static  dynamic readSecureData({required MyCashKey key}) async {
  //   const flutterSecureStorage = FlutterSecureStorage();
  //   return await flutterSecureStorage.read(key: key.name) ?? '';
  // }
}

//cache
enum MyCashKey { theme, lang }
