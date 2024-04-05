import 'package:movie_theater/core/api/api_consumer.dart';
import 'package:movie_theater/core/api/endpoints.dart';
import 'package:movie_theater/features/movies/data/models/movies_response_model.dart';

import 'package:movie_theater/features/movies/domain/entities/movie.dart';

abstract class MoviesRemoteDataSource {
  Future<MoviesResponseModel> getMoviesList(MovieSection movieSection);
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final ApiConsumer _apiConsumer;

  MoviesRemoteDataSourceImpl(this._apiConsumer);
  @override
  Future<MoviesResponseModel> getMoviesList(MovieSection movieSection) async {
    final response = await _apiConsumer.getData(
        url: switch (movieSection) {
      MovieSection.topRated => EndPoints.topRatedMovies,
      MovieSection.upComing || _ => EndPoints.upComing
    });

    return MoviesResponseModel.fromMap(response.data);
  }
}
