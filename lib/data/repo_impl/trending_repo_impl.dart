import 'package:netflix/data/data_source/trending_by_week_data_source.dart';
import 'package:netflix/data/models/movie_model.dart';

class TrendingRepoImpl extends TrendingByWeekDataSource {
  final TrendingByWeekDataSource movieDataSource;

  TrendingRepoImpl({required this.movieDataSource});

  @override
  Future<List<MovieImpl>> fetchTrendingByTheWeek() {
    return movieDataSource.fetchTrendingByTheWeek();
  }
}
