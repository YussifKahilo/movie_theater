import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_theater/features/movies/domain/entities/movie.dart';

import 'package:movie_theater/features/movies/domain/usecases/get_movies_usecase.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetMoviesUsecase _getMoviesUsecase;
  MoviesCubit(
    this._getMoviesUsecase,
  ) : super(MoviesInitial());

  static MoviesCubit get(context) => BlocProvider.of(context);

  Future<void> getMoviesList(MovieSection movieSection) async {
    emit(switch (movieSection) {
      MovieSection.topRated => GetTopRatedMoviesListLoadingState(),
      _ => GetUpComingMoviesListLoadingState(),
    });
    final result = await _getMoviesUsecase.call(movieSection);
    result.fold(
        (l) => emit(switch (movieSection) {
              MovieSection.topRated =>
                GetTopRatedMoviesListFailedState(l.message ?? 'Error'),
              _ => GetUpComingMoviesListFailedState(l.message ?? 'Error'),
            }),
        (r) => emit(switch (movieSection) {
              MovieSection.topRated =>
                GetTopRatedMoviesListSuccessState(r.$1, r.$2),
              _ => GetUpComingMoviesListSuccessState(r.$1, r.$2),
            }));
  }
}
