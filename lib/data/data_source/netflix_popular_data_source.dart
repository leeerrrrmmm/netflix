import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:netflix/data/models/movie_model.dart';

class NetflixPopularDataSource {
  final baseUrl = 'https://api.themoviedb.org/3/discover/movie';
  final _key = dotenv.env['API_KEY'];

  Future<List<MovieImpl>> fetchTopNetflix() async {
    try {
      final uri = Uri.parse(
        '$baseUrl?api_key=$_key&with_watch_providers=8&watch_region=US&sort_by=popularity.desc',
      );
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data['results'];
        final result = results.map((el) => MovieImpl.fromJson(el)).toList();
        return result;
      } else {
        log('Bad status code: ${response.statusCode}');
        throw Exception('EXCEPTION STATUS CODE');
      }
    } catch (e) {
      log('ERROR DATA SOURCE TOP NETFLIX: $e');
      throw Exception('EXCEPTION ERROR DATA SOURCE TOP NETFLIX: $e');
    }
  }
}
