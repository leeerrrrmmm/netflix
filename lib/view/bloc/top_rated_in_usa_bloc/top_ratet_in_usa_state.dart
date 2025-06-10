part of 'top_ratet_in_usa_bloc.dart';

@immutable
sealed class TopRatetInUsaState {}

final class TopRatetInUsaInitial extends TopRatetInUsaState {}

class TopRatedInUsaLoadind extends TopRatetInUsaState {}

class TopRatedInUsaLoaded extends TopRatetInUsaState {
  final List<MovieImpl> topRated;

  TopRatedInUsaLoaded({required this.topRated});
}

class TopRatedInUsaError extends TopRatetInUsaState {
  final String errorMessage;
  TopRatedInUsaError({required this.errorMessage});
}
