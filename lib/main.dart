import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:netflix/data/data_source/coming_soon.dart';
import 'package:netflix/data/data_source/movie_data_source.dart';
import 'package:netflix/data/data_source/netflix_popular_data_source.dart';
import 'package:netflix/data/data_source/now_plaing_data_source.dart';
import 'package:netflix/data/data_source/search_movie_data_source.dart';
import 'package:netflix/data/data_source/top_popular_in_usa.dart';
import 'package:netflix/data/data_source/trending_by_week_data_source.dart';
import 'package:netflix/data/repo_impl/movie_repo_impl.dart';
import 'package:netflix/data/repo_impl/now_repo_impl.dart';
import 'package:netflix/data/repo_impl/popular_netflix_repo_impl.dart';
import 'package:netflix/data/repo_impl/search_movie_repo_impl.dart';
import 'package:netflix/data/repo_impl/top_usa_repo_impl.dart';
import 'package:netflix/data/repo_impl/trending_repo_impl.dart';
import 'package:netflix/data/repo_impl/upcoming_impl.dart';
import 'package:netflix/domain/use_cases/now_playing_use_case.dart';
import 'package:netflix/domain/use_cases/popular_movie_use_cases.dart';
import 'package:netflix/domain/use_cases/popular_netflix_use_cases.dart';
import 'package:netflix/domain/use_cases/search_movie_use_cases.dart';
import 'package:netflix/domain/use_cases/top_usa_use_cases.dart';
import 'package:netflix/domain/use_cases/trending_use_case.dart';
import 'package:netflix/domain/use_cases/upcoming_use_cases.dart';
import 'package:netflix/firebase_options.dart';
import 'package:netflix/view/app.dart';
import 'package:netflix/view/bloc/popular_netflix/popular_netflix_bloc.dart';
import 'package:netflix/view/bloc/search_movie_bloc/search_movie_bloc.dart';
import 'package:netflix/view/bloc/top_rated_in_usa_bloc/top_ratet_in_usa_bloc.dart';
import 'package:netflix/view/bloc/upcoming_bloc/upcoming_bloc.dart';
import 'package:netflix/view/bloc/now_playing_bloc/now_playing_bloc.dart';
import 'package:netflix/view/bloc/popular_bloc/popular_movie_bloc.dart';
import 'package:netflix/view/bloc/trending_bloc/trending_bloc.dart';
import 'package:netflix/view/provider/user_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load();
  await initializeDateFormatting('en', null);

  final dataSource = MovieDataSource();
  final repository = MovieRepoImpl(movieDataSource: dataSource);
  final useCases = PopularMovieUseCases(popularMovieRepoImpl: repository);

  final nowDataSource = NowMovieDataSource();
  final nowRepo = NowMovieRepoImpl(movieDataSource: nowDataSource);
  final nowUseCases = NowMovieUseCases(popularMovieRepoImpl: nowRepo);

  final trendDataSource = TrendingByWeekDataSource();
  final trendRepo = TrendingRepoImpl(movieDataSource: trendDataSource);
  final trendUseCases = TrendingMovieUseCases(trendingMovieRepoImpl: trendRepo);

  final comingDataSource = ComingSoonDataSource();
  final comingRepo = UpcomingImpl(comingSoonDataSource: comingDataSource);
  final comingUseCases = UpcomingUseCases(upcomingMovieRepoImpl: comingRepo);

  final topInUsaDataSource = TopPopularInUsa();
  final topInUsaRepo = TopUsaRepoImpl(topPopularInUsa: topInUsaDataSource);
  final topInUsaUseCases = TopUsaUseCases(topUsaRepoImpl: topInUsaRepo);

  final popularNetflix = NetflixPopularDataSource();
  final popularNetflixRepo = PopularNetflixRepoImpl(
    netflixPopularDataSource: popularNetflix,
  );
  final popularNetflixUseCases = PopularNetflixUseCases(
    popularNetflixRepoImpl: popularNetflixRepo,
  );

  final searchMovieDataSource = SearchMovieDataSource();
  final searchMovieRepoImpl = SearchMovieRepoImpl(
    searchMovieDataSource: searchMovieDataSource,
  );
  final searchMovieUseCases = SearchMovieUseCases(
    searchMovieRepoImpl: searchMovieRepoImpl,
  );

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CurrentUserProvider())],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (_) =>
                    PopularMovieBloc(popularMovieUseCases: useCases)
                      ..add(LoadPopularMovies()),
          ),
          BlocProvider(
            create:
                (_) =>
                    NowPlayingBloc(nowMovieUseCases: nowUseCases)
                      ..add(LoadNowPlaing()),
          ),
          BlocProvider(
            create:
                (_) =>
                    TrendingBloc(trendUseCase: trendUseCases)
                      ..add(LoadTrending()),
          ),
          BlocProvider(
            create:
                (_) =>
                    UpcomingBloc(comingSoonDataSource: comingUseCases)
                      ..add(LoadUpcoming()),
          ),
          BlocProvider(
            create:
                (_) =>
                    TopRatetInUsaBloc(topUsaUseCases: topInUsaUseCases)
                      ..add(TopRatedInUsaLoad()),
          ),
          BlocProvider(
            create:
                (_) =>
                    PopularNetflixBloc(popularNetflixUseCases)
                      ..add(LoadPopularNetflix()),
          ),
          BlocProvider(
            create:
                (_) =>
                    SearchMovieBloc(searchMovieUseCases: searchMovieUseCases)
                      ..add(SearchMovieByQueryEvent(query: '')),
          ),
        ],
        child: const App(),
      ),
    ),
  );
}
