import 'package:netflix/data/models/movie_model.dart';

abstract class PopularNetflixRepo {
  Future<List<MovieImpl>> fetchPopularNetflix();
}
