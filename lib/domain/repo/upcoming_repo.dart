import 'package:netflix/data/models/movie_model.dart';

abstract class UpcomingRepo {
  Future<List<MovieImpl>> fetchUpcoming();
}
