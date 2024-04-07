import 'package:movie_theater/core/errors/exceptions.dart';
import 'package:movie_theater/core/network/network_info.dart';
import 'package:movie_theater/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:movie_theater/features/auth/data/models/user_model.dart';

import '../datasources/auth_remote_datasource.dart';
import '/features/auth/domain/entities/login_inputs.dart';
import '/features/auth/domain/entities/user.dart';
import '/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;
  final AuthLocalDatasource _authLocalDatasource;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl(
    this._authRemoteDatasource,
    this._authLocalDatasource,
    this._networkInfo,
  );

  @override
  Future<User> getUser(String? sessionId) async {
    bool isConnected = await _networkInfo.isConnected;
    if (isConnected) {
      UserModel userModel;
      if (sessionId != null) {
        userModel = await _authRemoteDatasource.getUser(sessionId);
      } else {
        String? savedSessionId = await _authLocalDatasource.getSessionId();
        if (savedSessionId != null) {
          userModel = await _authRemoteDatasource.getUser(savedSessionId);
        } else {
          throw const CacheException('No session id located');
        }
      }

      return userModel;
    } else {
      throw const NoInternetConnectionException('No interned connection');
    }
  }

  @override
  Future<String> login(LoginInputs loginInputs) async {
    bool isConnected = await _networkInfo.isConnected;
    if (isConnected) {
      final String requestToken =
          await _authRemoteDatasource.createRequestToken();
      await _authRemoteDatasource.login(loginInputs, requestToken);
      return await _authRemoteDatasource.createSession(requestToken);
    } else {
      throw const NoInternetConnectionException('No interned connection');
    }
  }
}
