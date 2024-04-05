import 'package:movie_theater/core/network/network_info.dart';
import 'package:movie_theater/features/movies/data/datasources/movies_remote_datasource.dart';
import 'package:movie_theater/features/movies/domain/entities/movie.dart';

import '../../domain/repositories/movies_repository.dart';
import '../models/movies_response_model.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource _moviesRemoteDataSource;
  final NetworkInfo _networkInfo;

  MoviesRepositoryImpl(this._moviesRemoteDataSource, this._networkInfo);

  @override
  Future<(List<Movie>, int)> getMoviesList(MovieSection movieSection) async {
    bool isConnected = await _networkInfo.isConnected;
    late MoviesResponseModel moviesResponseModel;
    if (isConnected) {
      moviesResponseModel =
          await _moviesRemoteDataSource.getMoviesList(movieSection);
    } else {
      moviesResponseModel =
          await _moviesRemoteDataSource.getMoviesList(movieSection);
    }
    return (moviesResponseModel.movies, moviesResponseModel.totalPages);
  }
}
