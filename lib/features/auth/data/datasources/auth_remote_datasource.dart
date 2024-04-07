import '/core/api/api_consumer.dart';
import '/core/api/endpoints.dart';
import '/features/auth/data/models/user_model.dart';
import '/features/auth/domain/entities/login_inputs.dart';

abstract class AuthRemoteDatasource {
  Future<String> createRequestToken();
  Future<void> login(LoginInputs loginInputs, String requestToken);
  Future<String> createSession(String requestToken);
  Future<UserModel> getUser(String sessionId);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final ApiConsumer _apiConsumer;

  AuthRemoteDatasourceImpl(this._apiConsumer);

  @override
  Future<String> createRequestToken() async {
    final response = await _apiConsumer.getData(
      url: EndPoints.createRequestToken,
    );
    return response.data['request_token'];
  }

  @override
  Future<void> login(LoginInputs loginInputs, String requestToken) async {
    final data = loginInputs.toMap();
    data.addAll({'request_token': requestToken});
    await _apiConsumer.postData(url: EndPoints.login, data: data);
  }

  @override
  Future<String> createSession(String requestToken) async {
    final response = await _apiConsumer.postData(
        url: EndPoints.createSession, data: {'request_token': requestToken});
    return response.data['session_id'];
  }

  @override
  Future<UserModel> getUser(String sessionId) async {
    final response = await _apiConsumer
        .getData(url: EndPoints.account, query: {'session_id': sessionId});
    return UserModel.fromMap(response.data);
  }
}
