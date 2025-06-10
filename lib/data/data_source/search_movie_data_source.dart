import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:netflix/data/models/movie_model.dart';

class SearchMovieDataSource {
  final baseUrl = 'https://api.themoviedb.org/3/search/movie';
  final _key = dotenv.env['API_KEY'] ?? '';

  Future<List<MovieImpl>> searchMovies(String query) async {
    try {
      final url = Uri.parse(
        '$baseUrl?query=${Uri.encodeQueryComponent(query)}&api_key=$_key',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body)['results'];
        final result =
            data.map<MovieImpl>((el) => MovieImpl.fromJson(el)).toList();
        return result;
      } else {
        throw Exception('ERROR FINDING MOVIE IN searchMovies RESPONSE != 200');
      }
    } catch (e) {
      log('ERROR FINDING MOVIE IN searchMovies $e');
      throw Exception('ERROR FINDING MOVIE IN searchMovies $e');
    }
  }
}
