abstract class CacheConsumer {
  // this function is to save data in cache using a key
  Future<bool> saveData({required String key, required dynamic value});

  // this function checks if this key have any data
  bool checkForData({required String key});

  // this function is to get data saved in cache
  dynamic getData({required String key});

  // remove data using specific key
  Future<bool> removeData({required String key});

  // clear all data saved in cache
  Future<bool> clearData();
}
