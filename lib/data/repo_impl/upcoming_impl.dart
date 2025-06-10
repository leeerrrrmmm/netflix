import 'package:netflix/data/data_source/coming_soon.dart';
import 'package:netflix/data/models/movie_model.dart';

class UpcomingImpl extends ComingSoonDataSource {
  final ComingSoonDataSource comingSoonDataSource;

  UpcomingImpl({required this.comingSoonDataSource});

  @override
  Future<List<MovieImpl>> fetchComingSooningByTheWeek(int page) {
    return comingSoonDataSource.fetchComingSooningByTheWeek(page);
  }
}
