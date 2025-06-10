part of 'search_movie_bloc.dart';

@immutable
sealed class SearchMovieState {}

final class SearchMovieInitial extends SearchMovieState {}

class LoadingMovies extends SearchMovieState {}

class LoadFindedMovie extends SearchMovieState {
  final List<MovieImpl> findedMovies;

  LoadFindedMovie({required this.findedMovies});
}

class ErrorFindMovies extends SearchMovieState {
  final String errorMessage;
  ErrorFindMovies({required this.errorMessage});
}
