import 'package:netflix/data/models/movie_model.dart';

abstract class MovieRepo {
  Future<List<MovieImpl>> fetchPopular();
}
