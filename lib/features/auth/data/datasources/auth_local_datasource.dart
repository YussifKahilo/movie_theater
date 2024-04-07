import 'package:movie_theater/core/cache/cache_consumer.dart';
import 'package:movie_theater/core/cache/cache_keys.dart';

abstract class AuthLocalDatasource {
  Future<void> saveSessionId(String sessionId);
  Future<String?> getSessionId();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final CacheConsumer _cacheConsumer;

  AuthLocalDatasourceImpl(this._cacheConsumer);

  @override
  Future<String?> getSessionId() async {
    return await _cacheConsumer.getData(key: CacheKeys.sessionId);
  }

  @override
  Future<void> saveSessionId(String sessionId) async {
    await _cacheConsumer.saveData(key: CacheKeys.sessionId, value: sessionId);
  }
}
