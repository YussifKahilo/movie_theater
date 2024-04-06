import 'package:movie_theater/features/movies/domain/entities/production_company.dart';

enum MovieSection { upComing, topRated }

class Movie {
  final String backDropImagePath;
  final String posterPath;
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final num voteCount;
  final num voteAverage;
  final num? runtime;
  final String? tagline;
  final String? status;
  final String? homePageUrl;
  final List<ProductionCompany>? productionCompanies;

  Movie({
    required this.backDropImagePath,
    required this.posterPath,
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.voteCount,
    required this.voteAverage,
    this.runtime,
    this.tagline,
    this.status,
    this.homePageUrl,
    this.productionCompanies,
  });
}
