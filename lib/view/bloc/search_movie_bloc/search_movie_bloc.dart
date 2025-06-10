import 'package:bloc_concurrency/bloc_concurrency.dart' show droppable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:netflix/data/models/movie_model.dart';
import 'package:netflix/domain/use_cases/search_movie_use_cases.dart';
import 'package:stream_transform/stream_transform.dart';
part 'search_movie_event.dart';
part 'search_movie_state.dart';

EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.debounce(duration), mapper);
  };
}

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  SearchMovieBloc({required SearchMovieUseCases searchMovieUseCases})
    : _searchMovieUseCases = searchMovieUseCases,
      super(SearchMovieInitial()) {
    on<SearchMovieByQueryEvent>(
      _onSearch,
      transformer: debounceDroppable(Duration(seconds: 1)),
    );
  }

  late final SearchMovieUseCases _searchMovieUseCases;

  _onSearch(
    SearchMovieByQueryEvent event,
    Emitter<SearchMovieState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(LoadFindedMovie(findedMovies: []));
      return;
    } else if (event.query.length <= 3) {
      emit(LoadFindedMovie(findedMovies: []));
      return;
    } else {
      final result = await _searchMovieUseCases.call(event.query);
      emit(LoadFindedMovie(findedMovies: result));
    }
  }
}
