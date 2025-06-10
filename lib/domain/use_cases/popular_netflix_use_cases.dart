import 'package:netflix/data/models/movie_model.dart';
import 'package:netflix/data/repo_impl/popular_netflix_repo_impl.dart';

class PopularNetflixUseCases {
  final PopularNetflixRepoImpl popularNetflixRepoImpl;
  PopularNetflixUseCases({required this.popularNetflixRepoImpl});

  Future<List<MovieImpl>> call() async {
    return popularNetflixRepoImpl.fetchPopularNetflix();
  }
}
