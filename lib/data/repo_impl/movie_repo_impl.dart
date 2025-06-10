import 'package:netflix/data/data_source/movie_data_source.dart';
import 'package:netflix/data/models/movie_model.dart';

class MovieRepoImpl extends MovieDataSource {
  final MovieDataSource movieDataSource;

  MovieRepoImpl({required this.movieDataSource});

  @override
  Future<List<MovieImpl>> fetchPopularMovie() async {
    return movieDataSource.fetchPopularMovie();
  }
}
