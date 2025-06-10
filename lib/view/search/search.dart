import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/data/models/movie_model.dart';
import 'package:netflix/view/bloc/search_movie_bloc/search_movie_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final findedMovies = context.select<SearchMovieBloc, List<MovieImpl>>((
      bloc,
    ) {
      final state = bloc.state;
      if (state is LoadFindedMovie) {
        return state.findedMovies;
      }
      return <MovieImpl>[];
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Search Movies')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                context.read<SearchMovieBloc>().add(
                  SearchMovieByQueryEvent(query: query),
                );
              },
              decoration: const InputDecoration(
                hintText: 'Search movies...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: findedMovies.length,
              itemBuilder: (context, index) {
                final movie = findedMovies[index];
                return Card(
                  color: const Color(0xff424242),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            movie.posterPath.isNotEmpty
                                ? Image.network(
                                  'https://image.tmdb.org/t/p/w185${movie.posterPath}',
                                  fit: BoxFit.cover,
                                  scale: 2.5,
                                  errorBuilder:
                                      (context, error, stackTrace) => Container(
                                        width: 146,
                                        height: 80,
                                        color: Colors.grey.shade800,
                                        child: const Icon(
                                          Icons.broken_image,
                                          color: Colors.white38,
                                          size: 40,
                                        ),
                                      ),
                                )
                                : Padding(
                                  padding: const EdgeInsets.only(left: 14.0),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    width: 146,
                                    height: 80,
                                    color: Colors.grey.shade800,
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      color: Colors.white38,
                                      size: 40,
                                    ),
                                  ),
                                ),
                            Flexible(
                              child: Text(
                                movie.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.play_circle_outline_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
