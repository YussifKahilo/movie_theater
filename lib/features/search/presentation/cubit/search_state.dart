part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<Movie> movies;
  final int totalPages;
  final int totalResults;
  const SearchSuccessState(
    this.movies,
    this.totalPages,
    this.totalResults,
  );
}

class MoreSearchSuccessState extends SearchState {
  final List<Movie> movies;
  final int totalPages;
  final int totalResults;
  const MoreSearchSuccessState(
    this.movies,
    this.totalPages,
    this.totalResults,
  );
}

class SearchFailedState extends SearchState {
  final String message;
  const SearchFailedState(this.message);
}

class SearchLoadingState extends SearchState {}
