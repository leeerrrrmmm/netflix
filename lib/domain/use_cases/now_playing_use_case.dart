import 'package:netflix/data/models/movie_model.dart';
import 'package:netflix/data/repo_impl/now_repo_impl.dart';

class NowMovieUseCases {
  final NowMovieRepoImpl popularMovieRepoImpl;

  NowMovieUseCases({required this.popularMovieRepoImpl});

  Future<List<MovieImpl>> call() async {
    return popularMovieRepoImpl.fetchNowPlaingMovie();
  }
}
