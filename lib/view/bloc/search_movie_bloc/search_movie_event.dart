part of 'search_movie_bloc.dart';

@immutable
sealed class SearchMovieEvent {}

class SearchMovieByQueryEvent extends SearchMovieEvent {
  final String query;

  SearchMovieByQueryEvent({required this.query});
}
