import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/movie_injection.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/save_remove_watchlist_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final MovieDetailBloc _movieDetailBloc = locator<MovieDetailBloc>();

  @override
  void initState() {
    _movieDetailBloc.add(LoadMovieDetail(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        bloc: _movieDetailBloc,
        builder: (context, state) {
          if (state is MovieDetailInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailSuccess) {
            return SafeArea(
              child: DetailContent(
                state.detail,
                state.listRecommendations,
                state.isAddedToWatchlist,
              ),
            );
          } else if (state is MovieDetailError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Expanded(
              child: Container(),
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  bool isAddedWatchlist;

  DetailContent(this.movie, this.recommendations, this.isAddedWatchlist);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  final SaveRemoveWatchlistBloc _saveRemoveWatchlistBloc = locator<SaveRemoveWatchlistBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (!widget.isAddedWatchlist) {
                                  _saveRemoveWatchlistBloc.add(AddWatchlist(movie: widget.movie));
                                } else {
                                  _saveRemoveWatchlistBloc.add(DeleteWatchlist(movie: widget.movie));
                                }
                              },
                              child: BlocListener<SaveRemoveWatchlistBloc, SaveRemoveWatchlistState>(
                                bloc: _saveRemoveWatchlistBloc,
                                listener: (context, state) {
                                  if (state is SaveRemoveWatchlistInitial) {
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        widget.isAddedWatchlist
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    );
                                  } else if (state is SaveRemoveWatchlistLoading) {
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        widget.isAddedWatchlist
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    );
                                  } else if (state is AddWatchlistSuccess) {
                                    widget.isAddedWatchlist = true;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(state.result)));
                                  } else if (state is DeleteWatchlistSuccess) {
                                    widget.isAddedWatchlist = false;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(state.result)));
                                  } else if (state is SaveRemoveWatchlistError) {
                                    Center(
                                      key: const Key('error_message'),
                                      child: Text(state.message),
                                    );
                                  } else {
                                    Expanded(
                                      child: Container(),
                                    );
                                  }
                                },
                                child: BlocBuilder<SaveRemoveWatchlistBloc, SaveRemoveWatchlistState>(
                                  bloc: _saveRemoveWatchlistBloc,
                                  builder: (context, state) {
                                    if (state is SaveRemoveWatchlistInitial) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          widget.isAddedWatchlist
                                              ? const Icon(Icons.check)
                                              : const Icon(Icons.add),
                                          const Text('Watchlist'),
                                        ],
                                      );
                                    } else
                                    if (state is SaveRemoveWatchlistLoading) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          widget.isAddedWatchlist
                                              ? const Icon(Icons.check)
                                              : const Icon(Icons.add),
                                          const Text('Watchlist'),
                                        ],
                                      );
                                    } else if (state is AddWatchlistSuccess) {
                                      widget.isAddedWatchlist = true;
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(Icons.check),
                                          Text('Watchlist'),
                                        ],
                                      );
                                    } else
                                    if (state is DeleteWatchlistSuccess) {
                                      widget.isAddedWatchlist = false;
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(Icons.add),
                                          Text('Watchlist'),
                                        ],
                                      );
                                    } else
                                    if (state is SaveRemoveWatchlistError) {
                                      return Center(
                                        key: const Key('error_message'),
                                        child: Text(state.message),
                                      );
                                    } else {
                                      return Expanded(
                                        child: Container(),
                                      );
                                    }
                                  }
                                ),
                              ),
                            ),
                            Text(
                              _showGenres(widget.movie.genres),
                            ),
                            Text(
                              _showDuration(widget.movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            Container(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final movie = widget.recommendations[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          MovieDetailPage.ROUTE_NAME,
                                          arguments: movie.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                          placeholder: (context, url) =>
                                          const Center(
                                            child:
                                            CircularProgressIndicator(),
                                          ),
                                          errorWidget:
                                              (context, url, error) =>
                                          const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: widget.recommendations.length,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
