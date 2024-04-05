import '../entities/movie.dart';

abstract class MoviesRepository {
  Future<(List<Movie> movies, int totalPages)> getMoviesList(
      MovieSection movieSection);
}
