part of 'trending_bloc.dart';

@immutable
sealed class TrendingEvent {}

class LoadTrending extends TrendingEvent {}
