import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:netflix/data/models/movie_model.dart';
import 'package:netflix/domain/use_cases/now_playing_use_case.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final NowMovieUseCases nowMovieUseCases;

  NowPlayingBloc({required this.nowMovieUseCases})
    : super(NowPlayingInitial()) {
    on<LoadNowPlaing>((event, emit) async {
      emit(NowPlaingMovieLoading());
      try {
        final popular = await nowMovieUseCases.call();
        emit(NowPlaingMovieLoaded(popular));
      } catch (e) {
        log('BLOC POPULAR MODULE FAILED');
        emit(NowPlaingMovieError('Error fetching popular movies'));
      }
    });
  }
}
