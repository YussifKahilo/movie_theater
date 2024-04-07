import 'package:dartz/dartz.dart';
import 'package:movie_theater/core/usecases/try_catch.dart';
import '/core/errors/failure.dart';
import '/core/usecases/base_usecase.dart';
import '/features/auth/domain/entities/login_inputs.dart';
import '/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase extends BaseUseCase<String, LoginInputs> {
  final AuthRepository _authRepository;

  LoginUsecase(this._authRepository);

  @override
  Future<Either<Failure, String>> call(LoginInputs params) async =>
      await tryCatch(tryFunction: () => _authRepository.login(params));
}
