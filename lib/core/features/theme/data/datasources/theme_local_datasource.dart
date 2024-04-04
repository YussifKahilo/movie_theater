import '/core/cache/cache_consumer.dart';
import '../../../../cache/cache_keys.dart';

abstract class ThemeLocalDataSource {
  Future<bool> changeTheme({required String themeMode});
  Future<String> getSavedTheme();
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final CacheConsumer cacheConsumer;
  ThemeLocalDataSourceImpl({
    required this.cacheConsumer,
  });
  @override
  Future<bool> changeTheme({required String themeMode}) async {
    return await cacheConsumer.saveData(key: CacheKeys.theme, value: themeMode);
  }

  @override
  Future<String> getSavedTheme() async {
    return cacheConsumer.checkForData(key: CacheKeys.theme)
        ? cacheConsumer.getData(key: CacheKeys.theme)!
        : 'light';
  }
}
