part of 'now_playing_bloc.dart';

@immutable
sealed class NowPlayingState {}

final class NowPlayingInitial extends NowPlayingState {}

class NowPlaingMovieLoading extends NowPlayingState {}

class NowPlaingMovieLoaded extends NowPlayingState {
  final List<MovieImpl> movies;

  NowPlaingMovieLoaded(this.movies);
}

class NowPlaingMovieError extends NowPlayingState {
  final String message;

  NowPlaingMovieError(this.message);
}
