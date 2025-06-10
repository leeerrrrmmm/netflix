import 'package:netflix/data/models/movie_model.dart';

abstract class NowMovieRepo {
  Future<List<MovieImpl>> fetchNowPlaingMovie();
}
