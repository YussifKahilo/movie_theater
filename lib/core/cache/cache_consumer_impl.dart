import 'package:shared_preferences/shared_preferences.dart';

import 'cache_consumer.dart';

class CacheConsumerImpl implements CacheConsumer {
  final SharedPreferences sharedPreferences;
  CacheConsumerImpl({
    required this.sharedPreferences,
  });

  @override
  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    }
    return false;
  }

  @override
  bool checkForData({required String key}) {
    return sharedPreferences.containsKey(key);
  }

  @override
  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  @override
  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  @override
  Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }
}
