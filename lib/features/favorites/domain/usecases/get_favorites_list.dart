import 'package:dartz/dartz.dart';
import 'package:movie_theater/core/errors/failure.dart';
import 'package:movie_theater/core/usecases/base_usecase.dart';
import 'package:movie_theater/core/usecases/try_catch.dart';
import 'package:movie_theater/features/favorites/domain/repositories/favorites_repository.dart';

import '../../../movies/domain/entities/movie.dart';

class GetFavoritesUsecase extends BaseUseCase<(List<Movie>, int), int> {
  final FavoritesRepository _repository;
  GetFavoritesUsecase(this._repository);

  @override
  Future<Either<Failure, (List<Movie>, int)>> call(int params) async =>
      await tryCatch(tryFunction: () => _repository.getFavorites(params));
}
