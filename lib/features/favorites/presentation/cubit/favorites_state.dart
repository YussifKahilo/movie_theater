part of 'favorites_cubit.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class MarkMovieFavoriteFailedState extends FavoritesState {
  final String message;
  const MarkMovieFavoriteFailedState(this.message);
}

class MarkMovieFavoriteLoadingState extends FavoritesState {}

class GetFavoritesSuccessState extends FavoritesState {
  final List<Movie> movies;
  final List<int> moviesIds;
  final int totalPages;
  const GetFavoritesSuccessState(
    this.movies,
    this.moviesIds,
    this.totalPages,
  );

  bool favoritesContains(int id) => moviesIds.contains(id);
}

class GetFavoritesFailedState extends FavoritesState {
  final String message;
  const GetFavoritesFailedState(this.message);
}

class GetFavoritesLoadingState extends FavoritesState {}

class GetMoreFavorites extends FavoritesState {
  final List<Movie> movies;
  final int totalPages;
  const GetMoreFavorites(this.movies, this.totalPages);
}
