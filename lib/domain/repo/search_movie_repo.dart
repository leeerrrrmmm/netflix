import 'package:netflix/data/models/movie_model.dart';

abstract class SearchMovieRepo {
  Future<List<MovieImpl>> searchMovie(String query);
}
