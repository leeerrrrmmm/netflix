import 'package:netflix/data/models/movie_model.dart';
import 'package:netflix/data/repo_impl/movie_repo_impl.dart';

class PopularMovieUseCases {
  final MovieRepoImpl popularMovieRepoImpl;

  PopularMovieUseCases({required this.popularMovieRepoImpl});

  Future<List<MovieImpl>> call() async {
    return popularMovieRepoImpl.fetchPopularMovie();
  }
}
