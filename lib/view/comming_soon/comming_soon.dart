import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix/components/build_text_widget.dart';
import 'package:netflix/view/bloc/upcoming_bloc/upcoming_bloc.dart';

class CommingSoon extends StatefulWidget {
  const CommingSoon({super.key});

  @override
  State<CommingSoon> createState() => _CommingSoonState();
}

class _CommingSoonState extends State<CommingSoon> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<UpcomingBloc>().add(LoadUpcoming());

    _scrollController.addListener(() {
      final pos = _scrollController.position;
      if (pos.pixels >= pos.maxScrollExtent - 300) {
        context.read<UpcomingBloc>().add(LoadMoreUpcoming());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String formatToMonthDay(String text) {
    final date = DateTime.tryParse(text);
    if (date == null) return '';
    return '${DateFormat.MMM('en').format(date)} ${date.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<UpcomingBloc, UpcomingState>(
        builder: (context, state) {
          if (state is UpcomingLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state is UpcomingLoaded) {
            final upcoming = state.upcoming;

            return ListView.builder(
              controller: _scrollController,
              itemCount: upcoming.length + 1, // +1 для индикатора загрузки
              itemBuilder: (context, index) {
                if (index < upcoming.length) {
                  final movie = upcoming[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // IMAGE
                      Container(
                        width: double.infinity,
                        height: 600,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://image.tmdb.org/t/p/original${movie.posterPath}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // REMIND & SHARE
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              children: const [
                                Icon(
                                  CupertinoIcons.bell_solid,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Remind Me',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(width: 30),
                            Column(
                              children: const [
                                Icon(
                                  Icons.share,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Share',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // TEXT CONTENT
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextBuild(
                              text:
                                  movie.releaseDate.isNotEmpty
                                      ? 'Coming Up: ${formatToMonthDay(movie.releaseDate)}'
                                      : '',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 14.0,
                              ),
                              child: TextBuild(
                                text: movie.originalTitle,
                                fontSize: 18.66,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            TextBuild(
                              text: movie.overview,
                              fontSize: 14.14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  // Индикатор загрузки внизу
                  return state.hasReachedMax
                      ? const SizedBox.shrink()
                      : const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
                }
              },
            );
          }

          if (state is UpcomingError) {
            return Center(
              child: Text(
                'Ошибка: ${state.message}',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
