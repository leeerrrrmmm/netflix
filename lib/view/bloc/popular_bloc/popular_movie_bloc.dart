import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:netflix/data/models/movie_model.dart';
import 'package:netflix/domain/use_cases/popular_movie_use_cases.dart';

part 'popular_movie_bloc_event.dart';
part 'popular_movie_bloc_state.dart';

class PopularMovieBloc
    extends Bloc<PopularMovieBlocEvent, PopularMovieBlocState> {
  final PopularMovieUseCases popularMovieUseCases;

  PopularMovieBloc({required this.popularMovieUseCases})
    : super(PopularMovieInitial()) {
    on<LoadPopularMovies>((event, emit) async {
      emit(PopularMovieLoading());
      try {
        final popular = await popularMovieUseCases.call();
        emit(PopularMovieLoaded(popular));
      } catch (e) {
        log('BLOC POPULAR MODULE FAILED');
        emit(PopularMovieError('Error fetching popular movies'));
      }
    });
  }
}
