import 'package:netflix/data/data_source/top_popular_in_usa.dart';
import 'package:netflix/data/models/movie_model.dart';

class TopUsaRepoImpl extends TopPopularInUsa {
  final TopPopularInUsa topPopularInUsa;

  TopUsaRepoImpl({required this.topPopularInUsa});

  @override
  Future<List<MovieImpl>> fetchTopRatedInUsa() {
    return topPopularInUsa.fetchTopRatedInUsa();
  }
}
