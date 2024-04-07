import 'package:movie_theater/features/movies/data/models/movie_model.dart';

class MoviesResponseModel {
  final int? page;
  final int? totalPages;
  final int totalResults;
  final List<MovieModel> movies;
  MoviesResponseModel(
      {required this.page,
      required this.totalPages,
      required this.movies,
      required this.totalResults});

  factory MoviesResponseModel.fromMap(Map<String, dynamic> map) {
    return MoviesResponseModel(
      page: map['page'],
      totalResults: map['total_results'],
      totalPages: map['total_pages'],
      movies: List<MovieModel>.from(
          map['results'].map((x) => MovieModel.fromMap(x))).toList(),
    );
  }
}
