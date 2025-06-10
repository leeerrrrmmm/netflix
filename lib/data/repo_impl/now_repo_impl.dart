import 'package:netflix/data/data_source/now_plaing_data_source.dart';
import 'package:netflix/data/models/movie_model.dart';

class NowMovieRepoImpl extends NowMovieDataSource {
  final NowMovieDataSource movieDataSource;

  NowMovieRepoImpl({required this.movieDataSource});

  @override
  Future<List<MovieImpl>> fetchNowPlaingMovie() {
    return movieDataSource.fetchNowPlaingMovie();
  }
}
