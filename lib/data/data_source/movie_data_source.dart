import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:netflix/data/models/movie_model.dart';

class MovieDataSource {
  final String apiKey = dotenv.env['API_KEY'] ?? '';
  final String baseUrl = 'https://api.themoviedb.org/3/movie';

  Future<List<MovieImpl>> fetchPopularMovie() async {
    try {
      int page = 1;
      final res = await http.get(
        Uri.parse('$baseUrl/popular?api_key=$apiKey&language=en-EN&page=$page'),
      );

      if (res.statusCode == 200) {
        final List results = json.decode(res.body)['results'];
        return results.map((json) => MovieImpl.fromJson(json)).toList();
      } else {
        throw Exception('STATUS CODE ERROR in popular NOT == 200');
      }
    } catch (e) {
      log('Error fetching popularMovies: $e');
      throw Exception('throw popular Error: $e');
    }
  }
}
