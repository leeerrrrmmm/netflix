import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:netflix/data/models/movie_model.dart';

class TopPopularInUsa {
  final String baseUrl = 'https://api.themoviedb.org/3/discover/movie';
  final String _key = dotenv.env['API_KEY'] ?? '';

  Future<List<MovieImpl>> fetchTopRatedInUsa() async {
    try {
      int page = 3;
      final url = Uri.parse(
        '$baseUrl?api_key=$_key&region=JP&sort_by=popularity.desc&page=$page&language=jp-JP',
      );

      final res = await http.get(url);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final List results = data['results'];

        return results.map((json) => MovieImpl.fromJson(json)).toList();
      } else {
        log('Ошибка запроса: ${res.statusCode}');
        throw Exception('Failed to load top-rated movies in USA');
      }
    } catch (e) {
      log('Ошибка в fetchTopRatedInUsa : $e');
      throw Exception('Ошибка в fetchTopRatedInUsa : $e');
    }
  }
}
