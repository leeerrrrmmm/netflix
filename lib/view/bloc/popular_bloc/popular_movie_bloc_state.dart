part of 'popular_movie_bloc.dart';

@immutable
sealed class PopularMovieBlocState {}

class PopularMovieInitial extends PopularMovieBlocState {}

class PopularMovieLoading extends PopularMovieBlocState {}

class PopularMovieLoaded extends PopularMovieBlocState {
  final List<MovieImpl> movies;

  PopularMovieLoaded(this.movies);
}

class PopularMovieError extends PopularMovieBlocState {
  final String message;

  PopularMovieError(this.message);
}
