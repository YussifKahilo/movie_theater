import '../entities/movie.dart';

abstract class MoviesRepository {
  Future<(List<Movie> movies, int totalPages)> getMoviesList(
      MovieSection movieSection);
  Future<(List<Movie>, int, int)> searchMovie(String query, int page);
}
