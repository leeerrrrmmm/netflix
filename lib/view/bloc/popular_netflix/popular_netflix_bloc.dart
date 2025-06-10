import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:netflix/data/models/movie_model.dart';
import 'package:netflix/domain/use_cases/popular_netflix_use_cases.dart';

part 'popular_netflix_event.dart';
part 'popular_netflix_state.dart';

class PopularNetflixBloc
    extends Bloc<PopularNetflixEvent, PopularNetflixState> {
  final PopularNetflixUseCases popularNetflixUseCases;
  PopularNetflixBloc(this.popularNetflixUseCases)
    : super(PopularNetflixInitial()) {
    on<LoadPopularNetflix>((event, emit) async {
      emit(LoadingPopularNetflix());
      try {
        final popularNetflix = await popularNetflixUseCases.call();
        emit(LoadedPopularNetflix(popularNetflix: popularNetflix));
      } catch (e) {
        log('BLOC MODULE TOP NETFLIX ERROR :$e');
      }
    });
  }
}
