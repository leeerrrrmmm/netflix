import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:netflix/data/models/movie_model.dart';

class ComingSoonDataSource {
  final String apiKey = dotenv.env['API_KEY'] ?? '';
  final String baseUrl = 'https://api.themoviedb.org/3/movie/upcoming';

  Future<List<MovieImpl>> fetchComingSooningByTheWeek(int page) async {
    try {
      final res = await http.get(
        Uri.parse('$baseUrl?api_key=$apiKey&language=en-EN&page=$page'),
      );
      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body)['results'];
        final parse = data.map((el) => MovieImpl.fromJson(el)).toList();
        return parse;
      } else {
        throw Exception('Error fetching fetchComingSooningByTheWeek: ');
      }
    } catch (e) {
      log('Error fetching fetchComingSooningByTheWeek: $e');
      throw Exception('throw fetchComingSooningByTheWeek Error: $e');
    }
  }
}
