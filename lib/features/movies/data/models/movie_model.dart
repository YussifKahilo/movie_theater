import 'package:movie_theater/features/movies/data/models/production_company_model.dart';

import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel(
      {required super.backDropImagePath,
      required super.posterPath,
      required super.id,
      required super.title,
      required super.overview,
      required super.releaseDate,
      required super.voteCount,
      required super.voteAverage,
      super.status,
      super.tagline,
      super.homePageUrl,
      super.runtime,
      super.productionCompanies});

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      homePageUrl: map['homepage'],
      backDropImagePath: map['backdrop_path'],
      posterPath: map['poster_path'],
      id: map['id'],
      title: map['title'],
      overview: map['overview'],
      releaseDate: map['release_date'],
      status: map['status'],
      voteCount: map['vote_count'],
      voteAverage: map['vote_average'],
      runtime: map['runtime'],
      tagline: map['tagline'],
      productionCompanies: map['production_companies'] == null
          ? null
          : List<ProductionCompanyModel>.from(map['production_companies']
              ?.map((x) => ProductionCompanyModel.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'homepage': homePageUrl,
      'backdrop_path': backDropImagePath,
      'poster_path': posterPath,
      'id': id,
      'title': title,
      'overview': overview,
      'release_date': releaseDate,
      'status': status,
      'vote_count': voteCount,
      'vote_average': voteAverage,
      'runtime': runtime,
      'tagline': tagline,
      'production_companies':
          productionCompanies?.map((x) => x.toDomain().toMap()).toList(),
    };
  }
}
