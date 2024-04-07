import 'package:movie_theater/core/api/api_consumer.dart';
import 'package:movie_theater/core/api/endpoints.dart';
import 'package:movie_theater/core/extensions/strings_customizability.dart';
import 'package:movie_theater/features/movies/data/models/movie_model.dart';
import 'package:movie_theater/features/movies/data/models/movies_response_model.dart';

import 'package:movie_theater/features/movies/domain/entities/movie.dart';

abstract class MoviesRemoteDataSource {
  Future<MoviesResponseModel> getMoviesList(MovieSection movieSection);
  Future<MovieModel> getMovie(int id);
  Future<MoviesResponseModel> searchMovie(String query, int page);
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

  @override
  Future<MoviesResponseModel> searchMovie(String query, int page) async {
    final response = await _apiConsumer
        .getData(url: EndPoints.search, query: {'query': query, 'page': page});

    return MoviesResponseModel.fromMap(response.data);
  }

  @override
  Future<MovieModel> getMovie(int id) async {
    final response = await _apiConsumer.getData(
        url: EndPoints.movie.placeId(id.toString()), query: {'movie_id': id});

    return MovieModel.fromMap(response.data);
  }
}
