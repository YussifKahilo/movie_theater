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

  Future<void> getMoviesTopRatedMoviesList() async {
    emit(GetTopRatedMoviesListLoadingState());
    final result = await _getMoviesUsecase.call(MovieSection.topRated);
    result.fold(
        (l) => emit(GetTopRatedMoviesListFailedState(l.message ?? 'Error')),
        (r) => emit(GetTopRatedMoviesListSuccessState(r.$1, r.$2)));
  }

  Future<void> getMoviesUpComingMoviesList() async {
    emit(GetUpComingMoviesListLoadingState());
    final result = await _getMoviesUsecase.call(MovieSection.upComing);
    result.fold(
        (l) => emit(GetUpComingMoviesListFailedState(l.message ?? 'Error')),
        (r) => emit(GetUpComingMoviesListSuccessState(r.$1, r.$2)));
  }
}
