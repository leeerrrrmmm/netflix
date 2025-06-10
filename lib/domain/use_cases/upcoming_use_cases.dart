import 'package:netflix/data/models/movie_model.dart';
import 'package:netflix/data/repo_impl/upcoming_impl.dart';

class UpcomingUseCases {
  final UpcomingImpl upcomingMovieRepoImpl;

  UpcomingUseCases({required this.upcomingMovieRepoImpl});

  Future<List<MovieImpl>> call(int page) async {
    return upcomingMovieRepoImpl.fetchComingSooningByTheWeek(page);
  }
}
