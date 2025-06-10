part of 'trending_bloc.dart';

@immutable
sealed class TrendingState {}

final class TrendingInitial extends TrendingState {}

class TrengindLoading extends TrendingState {}

class TrendingLoaded extends TrendingState {
  final List<MovieImpl> trending;
  TrendingLoaded({required this.trending});
}

class TrendingError extends TrendingState {
  final String message;
  TrendingError({required this.message});
}
