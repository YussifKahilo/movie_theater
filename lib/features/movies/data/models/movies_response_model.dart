import 'package:movie_theater/features/movies/data/models/movie_model.dart';

class MoviesResponseModel {
  final int page;
  final int totalPages;
  final List<MovieModel> movies;
  MoviesResponseModel({
    required this.page,
    required this.totalPages,
    required this.movies,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'total_pages': totalPages,
      'movies': movies.map((x) => x.toMap()).toList(),
    };
  }

  factory MoviesResponseModel.fromMap(Map<String, dynamic> map) {
    return MoviesResponseModel(
      page: map['page'],
      totalPages: map['total_pages'],
      movies: List<MovieModel>.from(
          map['results'].map((x) => MovieModel.fromMap(x))),
    );
  }
}
