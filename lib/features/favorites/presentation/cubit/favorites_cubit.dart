import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_theater/features/favorites/domain/usecases/get_favorites_list.dart';
import 'package:movie_theater/features/favorites/domain/usecases/mark_favorite_usecase.dart';

import '../../../movies/domain/entities/movie.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavoritesUsecase _getFavoritesUsecase;
  final MarkFavoritesUsecase _markFavoritesUsecase;
  FavoritesCubit(
    this._getFavoritesUsecase,
    this._markFavoritesUsecase,
  ) : super(FavoritesInitial());

  static FavoritesCubit get(context) => BlocProvider.of(context);

  Future<void> getFavorites(int page) async {
    if (page == 1) {
      emit(GetFavoritesLoadingState());
    }
    final results = await _getFavoritesUsecase.call(page);

    results.fold((l) => emit(GetFavoritesFailedState(l.message ?? 'Error')),
        (r) {
      List<Movie> moviesList;

      if (state is GetFavoritesSuccessState) {
        moviesList = (state as GetFavoritesSuccessState).movies;
        moviesList.addAll(r.$1);
        emit(GetMoreFavorites(moviesList, r.$2));
      } else {
        moviesList = r.$1;
      }

      emit(GetFavoritesSuccessState(
          moviesList, moviesList.map((e) => e.id).toList(), r.$2));
    });
  }

  Future<void> markFavorites(int movieId, bool favorite) async {
    emit(MarkMovieFavoriteLoadingState());

    final results = await _markFavoritesUsecase.call((favorite, movieId));

    results.fold(
        (l) => emit(MarkMovieFavoriteFailedState(l.message ?? 'Error')),
        (r) => getFavorites(1));
  }
}
