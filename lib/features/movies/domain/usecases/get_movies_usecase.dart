import 'package:dartz/dartz.dart';
import 'package:movie_theater/core/errors/failure.dart';
import 'package:movie_theater/core/usecases/base_usecase.dart';
import 'package:movie_theater/core/usecases/try_catch.dart';
import 'package:movie_theater/features/movies/domain/entities/movie.dart';
import 'package:movie_theater/features/movies/domain/repositories/movies_repository.dart';

class GetMoviesUsecase extends BaseUseCase<(List<Movie> movies, int totalPages),
    (int, MovieSection, bool)> {
  final MoviesRepository _moviesRepository;

  GetMoviesUsecase(this._moviesRepository);
  @override
  Future<Either<Failure, (List<Movie>, int)>> call(
          (int, MovieSection, bool) params) async =>
      await tryCatch(
        tryFunction: () =>
            _moviesRepository.getMoviesList(params.$1, params.$2, params.$3),
      );
}
