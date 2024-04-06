import 'package:movie_theater/core/db/db_consumer.dart';
import 'package:movie_theater/core/db/tables.dart';
import 'package:movie_theater/features/movies/data/models/movies_response_model.dart';

import 'package:movie_theater/features/movies/domain/entities/movie.dart';

import '../models/movie_model.dart';

abstract class MoviesLocaleDataSource {
  Future<MoviesResponseModel> getMoviesList(MovieSection movieSection);
  Future<void> saveMovies(List<MovieModel> movies, MovieSection movieSection);
  Future<void> clearSavedMovies();
}

class MoviesLocaleDataSourceImpl implements MoviesLocaleDataSource {
  final DBConsumer _dbConsumer;

  MoviesLocaleDataSourceImpl(this._dbConsumer);
  @override
  Future<MoviesResponseModel> getMoviesList(MovieSection movieSection) async {
    final response = await _dbConsumer.getData(
        table: SqlTables.moviesTable,
        where: 'movie_section = ${movieSection.index}');

    return MoviesResponseModel.fromMap({'results': response});
  }

  @override
  Future<void> saveMovies(
      List<MovieModel> movies, MovieSection movieSection) async {
    for (var movie in movies) {
      Map<String, dynamic> row = movie.toMap();
      row.addAll({'movie_section': movieSection.index});
      await _dbConsumer.addData(row: row, table: SqlTables.moviesTable);
    }
  }

  @override
  Future<void> clearSavedMovies() async =>
      await _dbConsumer.deleteData(table: SqlTables.moviesTable);
}
