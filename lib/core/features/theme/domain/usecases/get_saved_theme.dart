import 'package:dartz/dartz.dart';
import '../repositories/theme_repository.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecases/base_usecase.dart';
import '../../../../../core/usecases/no_param.dart';

class GetSavedThemeUseCase implements BaseUseCase<String, NoParams> {
  final ThemeRepository themeRepository;
  GetSavedThemeUseCase({
    required this.themeRepository,
  });

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await themeRepository.getSaved();
  }
}
