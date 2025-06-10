import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:netflix/data/models/movie_model.dart';

class NowMovieDataSource {
  final String apiKey = dotenv.env['API_KEY'] ?? '';
  final String baseUrl = 'https://api.themoviedb.org/3/movie';

  Future<List<MovieImpl>> fetchNowPlaingMovie() async {
    try {
      int page = 2;
      final res = await http.get(
        Uri.parse(
          '$baseUrl/now_playing?api_key=$apiKey&language=en-EN&page=$page',
        ),
      );

      if (res.statusCode == 200) {
        final List results = json.decode(res.body)['results'];
        return results.map((json) => MovieImpl.fromJson(json)).toList();
      } else {
        throw Exception('STATUS CODE ERROR in now_playing NOT == 200');
      }
    } catch (e) {
      log('Error fetching now_playing: $e');
      throw Exception('throw now_playing Error: $e');
    }
  }
}
