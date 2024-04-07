import 'package:dartz/dartz.dart';
import 'package:movie_theater/core/errors/failure.dart';
import 'package:movie_theater/core/usecases/base_usecase.dart';
import 'package:movie_theater/core/usecases/try_catch.dart';
import 'package:movie_theater/features/favorites/domain/repositories/favorites_repository.dart';

class MarkFavoritesUsecase
    extends BaseUseCase<void, (bool favorite, int movieId)> {
  final FavoritesRepository _repository;
  MarkFavoritesUsecase(this._repository);

  @override
  Future<Either<Failure, void>> call(
          (bool favorite, int movieId) params) async =>
      await tryCatch(
          tryFunction: () => _repository.markFavorite(params.$1, params.$2));
}
