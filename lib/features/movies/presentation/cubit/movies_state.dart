part of 'movies_cubit.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class GetTopRatedMoviesListSuccessState extends MoviesState {
  final List<Movie> movies;
  final int totalPages;
  const GetTopRatedMoviesListSuccessState(this.movies, this.totalPages);
}

class GetTopRatedMoviesListFailedState extends MoviesState {
  final String message;
  const GetTopRatedMoviesListFailedState(this.message);
}

class GetTopRatedMoviesListLoadingState extends MoviesState {}

class GetUpComingMoviesListSuccessState extends MoviesState {
  final List<Movie> movies;
  final int totalPages;
  const GetUpComingMoviesListSuccessState(this.movies, this.totalPages);
}

class GetUpComingMoviesListFailedState extends MoviesState {
  final String message;
  const GetUpComingMoviesListFailedState(this.message);
}

class GetUpComingMoviesListLoadingState extends MoviesState {}
