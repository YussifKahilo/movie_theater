import '../entities/movie.dart';

abstract class MoviesRepository {
  Future<(List<Movie> movies, int totalPages)> getMoviesList(
      int page, MovieSection movieSection, bool cacheData);
  Future<(List<Movie>, int, int)> searchMovie(String query, int page);
  Future<Movie> getMovie(int id, MovieSection movieSection, bool cacheData);
}
