import 'package:netflix/data/models/movie_model.dart';
import 'package:netflix/data/repo_impl/search_movie_repo_impl.dart';

class SearchMovieUseCases {
  final SearchMovieRepoImpl searchMovieRepoImpl;
  SearchMovieUseCases({required this.searchMovieRepoImpl});

  Future<List<MovieImpl>> call(String query) async {
    return searchMovieRepoImpl.searchMovie(query);
  }
}
