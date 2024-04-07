import 'package:dartz/dartz.dart';
import 'package:movie_theater/core/errors/failure.dart';
import 'package:movie_theater/core/usecases/base_usecase.dart';
import 'package:movie_theater/core/usecases/try_catch.dart';
import 'package:movie_theater/features/movies/domain/repositories/movies_repository.dart';

import '../../../movies/domain/entities/movie.dart';

class SearchMovieUsecase
    extends BaseUseCase<(List<Movie>, int, int), (String, int)> {
  final MoviesRepository _moviesRepository;

  SearchMovieUsecase(this._moviesRepository);

  @override
  Future<Either<Failure, (List<Movie>, int, int)>> call(
          (String, int) params) async =>
      await tryCatch(
          tryFunction: () =>
              _moviesRepository.searchMovie(params.$1, params.$2));
}
