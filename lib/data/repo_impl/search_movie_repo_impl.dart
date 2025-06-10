import 'package:netflix/data/data_source/search_movie_data_source.dart';
import 'package:netflix/data/models/movie_model.dart';
import 'package:netflix/domain/repo/search_movie_repo.dart';

class SearchMovieRepoImpl extends SearchMovieRepo {
  final SearchMovieDataSource searchMovieDataSource;

  SearchMovieRepoImpl({required this.searchMovieDataSource});

  @override
  Future<List<MovieImpl>> searchMovie(String query) {
    return searchMovieDataSource.searchMovies(query);
  }
}
