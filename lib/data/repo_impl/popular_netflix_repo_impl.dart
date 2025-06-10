import 'package:netflix/data/data_source/netflix_popular_data_source.dart';
import 'package:netflix/data/models/movie_model.dart';
import 'package:netflix/domain/repo/popular_netflix_repo.dart';

class PopularNetflixRepoImpl extends PopularNetflixRepo {
  final NetflixPopularDataSource netflixPopularDataSource;
  PopularNetflixRepoImpl({required this.netflixPopularDataSource});

  @override
  Future<List<MovieImpl>> fetchPopularNetflix() {
    return netflixPopularDataSource.fetchTopNetflix();
  }
}
