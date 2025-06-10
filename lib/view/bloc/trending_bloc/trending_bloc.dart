import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:netflix/data/models/movie_model.dart';
import 'package:netflix/domain/use_cases/trending_use_case.dart';

part 'trending_event.dart';
part 'trending_state.dart';

class TrendingBloc extends Bloc<TrendingEvent, TrendingState> {
  final TrendingMovieUseCases trendUseCase;
  TrendingBloc({required this.trendUseCase}) : super(TrendingInitial()) {
    on<LoadTrending>((event, emit) async {
      emit(TrengindLoading());
      try {
        final trending = await trendUseCase.call();
        emit(TrendingLoaded(trending: trending));
      } catch (e) {
        log('BLOC POPULAR MODULE FAILED');
        emit(TrendingError(message: 'Error fetching popular movies'));
      }
    });
  }
}
