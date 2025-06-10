import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:netflix/data/models/movie_model.dart';
import 'package:netflix/domain/use_cases/top_usa_use_cases.dart';

part 'top_ratet_in_usa_event.dart';
part 'top_ratet_in_usa_state.dart';

class TopRatetInUsaBloc extends Bloc<TopRatetInUsaEvent, TopRatetInUsaState> {
  final TopUsaUseCases topUsaUseCases;
  TopRatetInUsaBloc({required this.topUsaUseCases})
    : super(TopRatetInUsaInitial()) {
    on<TopRatedInUsaLoad>((event, emit) async {
      emit(TopRatedInUsaLoadind());

      try {
        final topRated = await topUsaUseCases.call();
        emit(TopRatedInUsaLoaded(topRated: topRated));
      } catch (e) {
        log('BLOC MODULE ERROR IN TOPRATEDINUSA :$e');
        throw Exception('BLOC MODULE ERROR IN TOPRATEDINUSA :$e');
      }
    });
  }
}
