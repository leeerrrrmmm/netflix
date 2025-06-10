part of 'upcoming_bloc.dart';

@immutable
sealed class UpcomingEvent {}

class LoadUpcoming extends UpcomingEvent {}

class LoadMoreUpcoming extends UpcomingEvent {}
