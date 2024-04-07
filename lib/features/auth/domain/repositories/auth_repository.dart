import '/features/auth/domain/entities/user.dart';
import '../entities/login_inputs.dart';

abstract class AuthRepository {
  Future<String> login(LoginInputs loginInputs);

  Future<User> getUser(String? sessionId);
}
