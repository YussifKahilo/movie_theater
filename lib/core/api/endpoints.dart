class EndPoints {
  static const String movie = 'movie/';
  static const String topRatedMovies = '$movie/top_rated';
  static const String upComing = 'discover/movie';

  static const String createRequestToken = 'authentication/token/new';
  static const String login = 'authentication/token/validate_with_login';
  static const String createSession = 'authentication/session/new';

  static const String account = 'account';
  static const String favorites = 'account/&id&/favorite/movies';
  static const String markFavorite = 'account/&id&/favorite';
}
