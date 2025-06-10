class MovieEntity {
  final int id;
  final String originalTitle;
  final String title;
  final String overview;
  final double popularity;
  final String posterPath;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;
  MovieEntity({
    required this.id,
    required this.originalTitle,
    required this.title,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
  });
}
