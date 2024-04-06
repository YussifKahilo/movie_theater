import 'package:movie_theater/core/network/network_info.dart';
import 'package:movie_theater/features/movies/data/datasources/movies_local_datasource.dart';
import 'package:movie_theater/features/movies/data/datasources/movies_remote_datasource.dart';
import 'package:movie_theater/features/movies/domain/entities/movie.dart';

import '../../domain/repositories/movies_repository.dart';
import '../models/movies_response_model.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource _moviesRemoteDataSource;
  final MoviesLocaleDataSource _moviesLocaleDataSource;
  final NetworkInfo _networkInfo;

  MoviesRepositoryImpl(this._moviesRemoteDataSource, this._networkInfo,
      this._moviesLocaleDataSource);

  @override
  Future<(List<Movie>, int)> getMoviesList(MovieSection movieSection) async {
    bool isConnected = await _networkInfo.isConnected;
    late MoviesResponseModel moviesResponseModel;
    if (isConnected) {
      _moviesLocaleDataSource.clearSavedMovies();
      moviesResponseModel =
          await _moviesRemoteDataSource.getMoviesList(movieSection);
      await _moviesLocaleDataSource.saveMovies(
          moviesResponseModel.movies, movieSection);
    } else {
      moviesResponseModel =
          await _moviesLocaleDataSource.getMoviesList(movieSection);
    }
    return (moviesResponseModel.movies, moviesResponseModel.totalPages ?? 1);
  }
}
