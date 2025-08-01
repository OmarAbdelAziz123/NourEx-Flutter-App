import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nourex/core/cache_helper/cache_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  // static bool isEnglish() => getCurrentLanguage() == "en";

  static Future<void> changeLanguageToEn() async {
    await CacheHelper.saveData(key: CacheKeys.currentLanguage, value: "en");
  }

  static String getCurrentLanguage() {
    return CacheHelper.getData(
      key: CacheKeys.currentLanguage,
    ) ?? "ar";
  }

  static Future<void> changeLanguageToAr() async {
    await CacheHelper.saveData(key: CacheKeys.currentLanguage, value: "ar");
  }

  static Future<void> changeLanguageToBn() async {
    await CacheHelper.saveData(key: CacheKeys.currentLanguage, value: "bn");
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);

    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }

  static Future<bool> clearAllData() async {
    return await sharedPreferences.clear();
  }

  static Future saveSecuredString({
    required String key,
    required dynamic value,
  }) async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint(
        "FlutterSecureStorage : setSecuredString with key : $key and value : $value");
    await flutterSecureStorage.write(key: key, value: value.toString());
  }

  static Future<String?> getSecuredString({
    required String key,
  }) async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint('FlutterSecureStorage : getSecuredString with key :');
    try {
      return await flutterSecureStorage.read(key: key);
    } catch (e) {
      return null;
    }
  }

  static Future clearAllSecuredData() async {
    debugPrint('FlutterSecureStorage : all data has been cleared');
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.deleteAll();
  }
}