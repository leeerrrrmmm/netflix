part of 'popular_netflix_bloc.dart';

@immutable
sealed class PopularNetflixEvent {}

class LoadPopularNetflix extends PopularNetflixEvent {}
