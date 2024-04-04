import 'package:dartz/dartz.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../domain/repositories/theme_repository.dart';
import '../datasources/theme_local_datasource.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource themeLocalDataSource;
  ThemeRepositoryImpl({
    required this.themeLocalDataSource,
  });

  @override
  Future<Either<Failure, bool>> changeTheme({required String themeMode}) async {
    try {
      final saved =
          await themeLocalDataSource.changeTheme(themeMode: themeMode);

      return Right(saved);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getSaved() async {
    try {
      final langLocal = await themeLocalDataSource.getSavedTheme();

      return Right(langLocal);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }
}
