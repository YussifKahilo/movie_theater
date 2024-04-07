import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/core/utils/functions.dart';

import 'package:movie_theater/features/movies/domain/entities/movie.dart';
import 'package:movie_theater/features/search/domain/usecases/search_movie.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchMovieUsecase _searchMovieUsecase;

  SearchCubit(
    this._searchMovieUsecase,
  ) : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of<SearchCubit>(context);

  Future<void> searchFor(String query, int page) async {
    if (page == 1) {
      emit(SearchLoadingState());
      cancelCurrentRequest();
    }
    final result = await _searchMovieUsecase.call((query, page));

    result.fold((l) => emit(SearchFailedState(l.message ?? 'Error')), (r) {
      List<Movie> moviesList;
      if (state is SearchSuccessState) {
        moviesList = (state as SearchSuccessState).movies;
        emit(MoreSearchSuccessState(moviesList, r.$2, r.$2));
        moviesList.addAll(r.$1);
      } else {
        moviesList = r.$1;
      }
      emit(SearchSuccessState(moviesList, r.$2, r.$2));
    });
  }
}
