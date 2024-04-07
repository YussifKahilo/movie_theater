part of 'favorites_cubit.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class MarkMovieFavoriteSuccessState extends FavoritesState {}

class MarkMovieFavoriteFailedState extends FavoritesState {
  final String message;
  const MarkMovieFavoriteFailedState(this.message);
}

class MarkMovieFavoriteLoadingState extends FavoritesState {}
