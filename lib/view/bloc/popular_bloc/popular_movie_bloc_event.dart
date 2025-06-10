part of 'popular_movie_bloc.dart';

@immutable
sealed class PopularMovieBlocEvent {}

class LoadPopularMovies extends PopularMovieBlocEvent {}
