import 'package:netflix/data/models/movie_model.dart';
import 'package:netflix/data/repo_impl/trending_repo_impl.dart';

class TrendingMovieUseCases {
  final TrendingRepoImpl trendingMovieRepoImpl;

  TrendingMovieUseCases({required this.trendingMovieRepoImpl});

  Future<List<MovieImpl>> call() async {
    return trendingMovieRepoImpl.fetchTrendingByTheWeek();
  }
}
