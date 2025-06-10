import 'package:netflix/data/models/movie_model.dart';

abstract class TopUsaRepo {
  Future<List<MovieImpl>> fetchTopRatedInUsa();
}
