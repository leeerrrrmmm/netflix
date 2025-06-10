import 'package:netflix/data/models/movie_model.dart';
import 'package:netflix/data/repo_impl/top_usa_repo_impl.dart';

class TopUsaUseCases {
  final TopUsaRepoImpl topUsaRepoImpl;

  TopUsaUseCases({required this.topUsaRepoImpl});

  Future<List<MovieImpl>> call() async {
    return topUsaRepoImpl.fetchTopRatedInUsa();
  }
}
