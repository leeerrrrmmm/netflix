part of 'upcoming_bloc.dart';

@immutable
sealed class UpcomingState {}

final class UpcomingInitial extends UpcomingState {}

class UpcomingLoading extends UpcomingState {}

class UpcomingLoaded extends UpcomingState {
  final List<MovieImpl> upcoming;
  final int currentPage;
  final bool hasReachedMax;
  UpcomingLoaded({
    required this.upcoming,
    required this.currentPage,
    required this.hasReachedMax,
  });

  UpcomingLoaded copyWith({
    final List<MovieImpl>? upcoming,
    final int? currentPage,
    final bool? hasReachedMax,
  }) {
    return UpcomingLoaded(
      upcoming: upcoming ?? this.upcoming,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class UpcomingError extends UpcomingState {
  final String message;
  UpcomingError({required this.message});
}
