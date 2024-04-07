import '/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import '/core/errors/failure.dart';
import '/core/usecases/base_usecase.dart';
import '/features/auth/domain/repositories/auth_repository.dart';

class GetUserUsecase extends BaseUseCase<User, String?> {
  final AuthRepository _authRepository;

  GetUserUsecase(this._authRepository);

  @override
  Future<Either<Failure, User>> call(String? params) async {
    try {
      final result = await _authRepository.getUser(params);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
