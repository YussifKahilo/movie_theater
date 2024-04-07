import 'package:dartz/dartz.dart';
import '/core/errors/failure.dart';
import '/core/usecases/base_usecase.dart';
import '/features/auth/domain/entities/login_inputs.dart';
import '/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase extends BaseUseCase<String, LoginInputs> {
  final AuthRepository _authRepository;

  LoginUsecase(this._authRepository);

  @override
  Future<Either<Failure, String>> call(LoginInputs params) async {
    try {
      final result = await _authRepository.login(params);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
