import 'package:dartz/dartz.dart';
import 'package:movie_theater/core/errors/exceptions.dart';
import 'package:movie_theater/core/errors/failure.dart';
import 'package:movie_theater/core/usecases/base_usecase.dart';
import 'package:movie_theater/core/usecases/try_catch.dart';
import 'package:movie_theater/features/movies/domain/entities/movie.dart';
import 'package:movie_theater/features/movies/domain/repositories/movies_repository.dart';

class GetMoviesUsecase
    extends BaseUseCase<(List<Movie> movies, int totalPages), MovieSection> {
  final MoviesRepository _moviesRepository;

  GetMoviesUsecase(this._moviesRepository);
  @override
  Future<Either<Failure, (List<Movie>, int)>> call(MovieSection params) async =>
      await tryCatch(
        tryFunction: () => _moviesRepository.getMoviesList(params),
        catchFunction: (exception) {
          if (exception is ServerException) {
            return ServerFailure(exception.message);
          } else if (exception is CacheException) {
            return CacheFailure(exception.message);
          }
        },
      );
}
