import 'package:movie_theater/core/db/db_consumer.dart';
import 'package:movie_theater/core/db/tables.dart';
import 'package:movie_theater/features/movies/data/models/movies_response_model.dart';

import 'package:movie_theater/features/movies/domain/entities/movie.dart';

import '../models/movie_model.dart';

abstract class MoviesLocaleDataSource {
  Future<MoviesResponseModel> getMoviesList(MovieSection movieSection);
  Future<void> saveMovies(List<MovieModel> movies, MovieSection movieSection);
  Future<void> saveMovie(MovieModel movie, MovieSection movieSection);
  Future<void> clearSavedMovies();
  Future<MoviesResponseModel> searchMovie(String query);
}

class MoviesLocaleDataSourceImpl implements MoviesLocaleDataSource {
  final DBConsumer _dbConsumer;

  MoviesLocaleDataSourceImpl(this._dbConsumer);
  @override
  Future<MoviesResponseModel> getMoviesList(MovieSection movieSection) async {
    final response = await _dbConsumer.getData(
        table: SqlTables.moviesTable,
        where: 'movie_section = ${movieSection.index}');

    return MoviesResponseModel.fromMap(
        {'results': response, 'total_results': response.length});
  }

  @override
  Future<void> saveMovies(
      List<MovieModel> movies, MovieSection movieSection) async {
    for (var movie in movies) {
      await saveMovie(movie, movieSection);
    }
  }

  @override
  Future<void> saveMovie(MovieModel movie, MovieSection movieSection) async {
    Map<String, dynamic> row = movie.toMap();
    row.addAll({'movie_section': movieSection.index});
    await _dbConsumer.addData(row: row, table: SqlTables.moviesTable);
  }

  @override
  Future<void> clearSavedMovies() async =>
      await _dbConsumer.deleteData(table: SqlTables.moviesTable);

  @override
  Future<MoviesResponseModel> searchMovie(String query) async {
    List<Map<String, dynamic>> rows = await _dbConsumer.getData(
        table: SqlTables.moviesTable, where: 'title = $query');
    return MoviesResponseModel.fromMap(
        {"results": rows.map((e) => MovieModel.fromMap(e))});
  }
}
