import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/view/bloc/now_playing_bloc/now_playing_bloc.dart';
import 'package:netflix/view/bloc/popular_bloc/popular_movie_bloc.dart';
import 'package:netflix/view/bloc/popular_netflix/popular_netflix_bloc.dart';
import 'package:netflix/view/bloc/top_rated_in_usa_bloc/top_ratet_in_usa_bloc.dart';
import 'package:netflix/view/bloc/trending_bloc/trending_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PopularNetflixBloc>().add(LoadPopularNetflix());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/prew.png'),
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              height: 435,
              child: Stack(
                children: [
                  Positioned(
                    top: 50,
                    right: 30,
                    left: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/images/icon.png'),
                        GestureDetector(
                          onTap: () {
                            //todo tv shows logic
                          },
                          child: Text(
                            'TV Shows',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //todo movies logic
                          },
                          child: Text(
                            ' Movies',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //todo my list logic
                          },
                          child: Text(
                            'My List',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: const Text(
                '#2 in Ukraint Today',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 11, 60, 43),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // my list
                  IconButton(
                    onPressed: () {
                      //todo my list logic
                    },
                    icon: Column(children: [Icon(Icons.add), Text("My List")]),
                  ),
                  GestureDetector(
                    onTap: () {
                      //todo play logic
                    },
                    child: Container(
                      width: 110,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color(0xffc4c4c4),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.play_arrow, color: Colors.black, size: 50),
                          Text(
                            'Play',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // play
                  IconButton(
                    onPressed: () {
                      //todo info logic (detail)
                    },
                    icon: Column(
                      children: [Icon(Icons.info_outline), Text("Info")],
                    ),
                  ),
                  //info
                ],
              ),
            ),

            /// Popular on Netflix
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Popular on Netflix',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CustomBlocBuilder<
              PopularNetflixBloc,
              PopularNetflixState,
              LoadedPopularNetflix
            >(getMovies: (state) => state.popularNetflix),

            /// Сейчас в прокате
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Now Playing',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CustomBlocBuilder<
              NowPlayingBloc,
              NowPlayingState,
              NowPlaingMovieLoaded
            >(getMovies: (state) => state.movies),

            /// В тренде(неделя)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Trending',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CustomBlocBuilder<TrendingBloc, TrendingState, TrendingLoaded>(
              getMovies: (state) => state.trending,
            ),

            /// Популярно в Японии
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Popular in Japan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CustomBlocBuilder<
              TopRatetInUsaBloc,
              TopRatetInUsaState,
              TopRatedInUsaLoaded
            >(getMovies: (state) => state.topRated),

            /// Популярные фильмы
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Popular',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CustomBlocBuilder<
              PopularMovieBloc,
              PopularMovieBlocState,
              PopularMovieLoaded
            >(getMovies: (state) => state.movies),
          ],
        ),
      ),
    );
  }
}

class CustomBlocBuilder<B extends BlocBase<S>, S, L extends S>
    extends StatelessWidget {
  final List<dynamic> Function(L state) getMovies;

  const CustomBlocBuilder({super.key, required this.getMovies});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      builder: (context, state) {
        if (state.toString().contains('Loadind') ||
            state.toString().contains('Loading')) {
          return SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder:
                  (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade800,
                      highlightColor: Colors.grey.shade600,
                      child: Container(
                        width: 120,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
            ),
          );
        } else if (state is L) {
          final movies = getMovies(state);
          return SizedBox(
            height: 250,
            child: ListView.builder(
              cacheExtent: 1000,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      movie.posterPath != null && movie.posterPath.isNotEmpty
                          ? Image.network(
                            'https://image.tmdb.org/t/p/original${movie.posterPath}',
                            height: 180,
                          )
                          : const Icon(Icons.image_not_supported),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state.toString().contains('Error')) {
          final message =
              (state as dynamic).errorMessage ?? 'Неизвестная ошибка';
          return Center(child: Text('Ошибка: $message'));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
