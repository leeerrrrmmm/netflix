import 'package:netflix/data/models/movie_model.dart';

abstract class TrendingByTheWeekRepo {
  Future<List<MovieImpl>> fetchTrendingMovie();
}
