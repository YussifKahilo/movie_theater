import 'package:movie_theater/core/network/network_info.dart';
import 'package:movie_theater/features/movies/data/datasources/movies_local_datasource.dart';
import 'package:movie_theater/features/movies/data/datasources/movies_remote_datasource.dart';
import 'package:movie_theater/features/movies/data/models/movie_model.dart';
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
  Future<(List<Movie>, int)> getMoviesList(
      MovieSection movieSection, bool cacheData) async {
    bool isConnected = await _networkInfo.isConnected;
    late MoviesResponseModel moviesResponseModel;
    if (isConnected) {
      _moviesLocaleDataSource.clearSavedMovies();
      moviesResponseModel =
          await _moviesRemoteDataSource.getMoviesList(movieSection);
      if (cacheData) {
        await _moviesLocaleDataSource.saveMovies(
            moviesResponseModel.movies, movieSection);
      }
    } else {
      moviesResponseModel =
          await _moviesLocaleDataSource.getMoviesList(movieSection);
    }
    return (moviesResponseModel.movies, moviesResponseModel.totalPages ?? 1);
  }

  @override
  Future<(List<Movie>, int, int)> searchMovie(String query, int page) async {
    bool isConnected = await _networkInfo.isConnected;
    late MoviesResponseModel moviesResponseModel;
    if (isConnected) {
      moviesResponseModel =
          await _moviesRemoteDataSource.searchMovie(query, page);
    } else {
      moviesResponseModel = await _moviesLocaleDataSource.searchMovie(query);
    }
    return (
      moviesResponseModel.movies,
      moviesResponseModel.totalPages ?? 1,
      moviesResponseModel.totalResults
    );
  }

  @override
  Future<Movie> getMovie(
      int id, MovieSection movieSection, bool cacheData) async {
    bool isConnected = await _networkInfo.isConnected;
    late MovieModel movie;
    if (isConnected) {
      movie = await _moviesRemoteDataSource.getMovie(id);
      if (cacheData) {
        await _moviesLocaleDataSource.saveMovie(movie, movieSection);
      }
    } else {
      movie = await _moviesLocaleDataSource.getMovie(id);
    }
    return movie;
  }
}
