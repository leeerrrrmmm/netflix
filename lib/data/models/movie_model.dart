import 'package:netflix/domain/entity/movie_entity.dart';

class MovieImpl extends MovieEntity {
  MovieImpl({
    required super.id,
    required super.originalTitle,
    required super.title,
    required super.overview,
    required super.posterPath,
    required super.popularity,
    required super.voteAverage,
    required super.voteCount,
    required super.releaseDate,
  });

  factory MovieImpl.fromJson(Map<String, dynamic> data) {
    return MovieImpl(
      id: data['id'] ?? 0,
      originalTitle: data['original_title'] ?? 'no original title',
      title: data['title'] ?? 'no title',
      overview: data['overview'] ?? 'no overview',
      posterPath: data['poster_path'] ?? '',
      popularity:
          (data['popularity'] is int)
              ? (data['popularity'] as int).toDouble()
              : data['popularity'] ?? 0.0,
      voteAverage:
          (data['vote_average'] is int)
              ? (data['vote_average'] as int).toDouble()
              : data['vote_average'] ?? 0.0,
      voteCount:
          (data['vote_count'] is int)
              ? (data['vote_count'] as int)
              : data['vote_count'] ?? 0,
      releaseDate: data['release_date'] ?? '',
    );
  }
}
