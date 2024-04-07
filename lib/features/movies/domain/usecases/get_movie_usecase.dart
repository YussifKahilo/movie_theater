import 'package:dartz/dartz.dart';
import 'package:movie_theater/core/errors/failure.dart';
import 'package:movie_theater/core/usecases/base_usecase.dart';
import 'package:movie_theater/core/usecases/try_catch.dart';
import 'package:movie_theater/features/movies/domain/entities/movie.dart';
import 'package:movie_theater/features/movies/domain/repositories/movies_repository.dart';

class GetMovieUsecase extends BaseUseCase<Movie, (int, MovieSection, bool)> {
  final MoviesRepository _moviesRepository;

  GetMovieUsecase(this._moviesRepository);
  @override
  Future<Either<Failure, Movie>> call((int, MovieSection, bool) params) async =>
      await tryCatch(
        tryFunction: () =>
            _moviesRepository.getMovie(params.$1, params.$2, params.$3),
      );
}
