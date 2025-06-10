import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:netflix/data/models/movie_model.dart';
import 'package:netflix/domain/use_cases/upcoming_use_cases.dart';
part 'upcoming_event.dart';
part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  final UpcomingUseCases comingSoonDataSource;
  UpcomingBloc({required this.comingSoonDataSource})
    : super(UpcomingInitial()) {
    on<LoadUpcoming>((event, emit) async {
      emit(UpcomingLoading());
      try {
        final trending = await comingSoonDataSource.call(1);
        emit(
          UpcomingLoaded(
            upcoming: trending,
            currentPage: 1,
            hasReachedMax: trending.isEmpty,
          ),
        );
      } catch (e) {
        log('BLOC POPULAR MODULE FAILED');
        emit(UpcomingError(message: 'Error fetching popular movies'));
      }
    });

    on<LoadMoreUpcoming>((event, emit) async {
      final state = this.state;
      if (state is UpcomingLoaded && !state.hasReachedMax) {
        try {
          final nexPage = state.currentPage + 1;
          final trending = await comingSoonDataSource.call(nexPage);

          emit(
            state.copyWith(
              upcoming: List.of(state.upcoming)..addAll(trending),
              currentPage: nexPage,
              hasReachedMax: trending.isEmpty,
            ),
          );
        } catch (e) {
          log('BLOC UPCOMING LOAD MORE FAILED: $e');
          emit(
            UpcomingError(message: 'Ошибка при загрузке следующей страницы'),
          );
        }
      }
    });
  }
}
