import 'package:movie_theater/features/movies/data/models/movie_model.dart';

abstract class FavoritesRepository {
  Future<void> markFavorite(bool favorite, int movieId);

  Future<(List<MovieModel>, int)> getFavorites(int page);
}
