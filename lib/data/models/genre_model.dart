import 'package:netflix/domain/entity/genre_entity.dart';

class GenreModel extends GenreEntity {
  GenreModel({required super.ids});

  factory GenreModel.fromJson(Map<String, dynamic> data) {
    return GenreModel(ids: List<int>.from(data['genre_ids'] ?? []));
  }
}
