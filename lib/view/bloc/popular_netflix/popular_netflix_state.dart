part of 'popular_netflix_bloc.dart';

@immutable
sealed class PopularNetflixState {}

final class PopularNetflixInitial extends PopularNetflixState {}

class LoadingPopularNetflix extends PopularNetflixState {}

class LoadedPopularNetflix extends PopularNetflixState {
  final List<MovieImpl> popularNetflix;

  LoadedPopularNetflix({required this.popularNetflix});
}

class ErrorPopularNetflix extends PopularNetflixState {
  final String errorMessage;

  ErrorPopularNetflix({required this.errorMessage});
}
