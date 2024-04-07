import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_theater/features/movies/domain/entities/movie.dart';
import 'package:movie_theater/features/movies/domain/usecases/get_movies_usecase.dart';

import '../../domain/usecases/get_movie_usecase.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetMoviesUsecase _getMoviesUsecase;
  final GetMovieUsecase _getMovieUsecase;
  MoviesCubit(
    this._getMoviesUsecase,
    this._getMovieUsecase,
  ) : super(MoviesInitial());

  static MoviesCubit get(context) => BlocProvider.of(context);

  Future<void> getMovie(int id, bool cacheData) async {
    emit(GetMovieLoadingState());
    final result =
        await _getMovieUsecase.call((id, MovieSection.topRated, cacheData));
    result.fold((l) => emit(GetMovieFailedState(l.message ?? 'Error')),
        (r) => emit(GetMovieSuccessState(r)));
  }

  Future<void> getMoviesTopRatedMoviesList() async {
    emit(GetTopRatedMoviesListLoadingState());
    final result =
        await _getMoviesUsecase.call((1, MovieSection.topRated, true));
    result.fold(
        (l) => emit(GetTopRatedMoviesListFailedState(l.message ?? 'Error')),
        (r) => emit(GetTopRatedMoviesListSuccessState(r.$1, r.$2)));
  }

  Future<void> getMoviesUpComingMoviesList() async {
    emit(GetUpComingMoviesListLoadingState());
    final result =
        await _getMoviesUsecase.call((1, MovieSection.upComing, true));
    result.fold(
        (l) => emit(GetUpComingMoviesListFailedState(l.message ?? 'Error')),
        (r) => emit(GetUpComingMoviesListSuccessState(r.$1, r.$2)));
  }

  Future<void> getMovies(int page, MovieSection movieSection) async {
    if (page == 1) {
      emit(GetMoviesLoadingState());
    }
    final result = await _getMoviesUsecase.call((page, movieSection, false));
    result.fold((l) => emit(GetMoviesFailedState(l.message ?? 'Error')), (r) {
      List<Movie> moviesList;
      if (state is GetMoviesSuccessState) {
        moviesList = (state as GetMoviesSuccessState).movies;
        emit(GetMoreMovies(moviesList, r.$2));
        moviesList.addAll(r.$1);
      } else {
        moviesList = r.$1;
      }
      emit(GetMoviesSuccessState(moviesList, r.$2));
    });
  }
}
