import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:tv/tv.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/presentation/bloc/save_remove_watchlist_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/pages/tv_episode_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/tv_injection.dart';

class TVDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  TVDetailPage({required this.id});

  @override
  _TVDetailPageState createState() => _TVDetailPageState();
}

class _TVDetailPageState extends State<TVDetailPage> {
  final TVDetailBloc _tvDetailBloc = locator<TVDetailBloc>();

  @override
  void initState() {
    _tvDetailBloc.add(LoadTVDetail(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TVDetailBloc, TVDetailState>(
        bloc: _tvDetailBloc,
        builder: (context, state) {
          if (state is TVDetailInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TVDetailLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TVDetailSuccess) {
            return SafeArea(
              child: DetailContent(
                state.detail,
                state.listRecommendations,
                state.isAddedToWatchlist,
              ),
            );
          } else if (state is TVDetailError) {
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
  final TVDetail tv;
  final List<TV> recommendations;
  bool isAddedWatchlist;

  DetailContent(this.tv, this.recommendations, this.isAddedWatchlist);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  final SaveRemoveWatchlistTVBloc _saveRemoveWatchlistTVBloc = locator<SaveRemoveWatchlistTVBloc>();

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
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
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
                              widget.tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (!widget.isAddedWatchlist) {
                                  _saveRemoveWatchlistTVBloc.add(AddWatchlistTV(tv: widget.tv));
                                } else {
                                  _saveRemoveWatchlistTVBloc.add(DeleteWatchlistTV(tv: widget.tv));
                                }
                              },
                              child: BlocListener<SaveRemoveWatchlistTVBloc, SaveRemoveWatchlistTVState>(
                                bloc: _saveRemoveWatchlistTVBloc,
                                listener: (context, state) {
                                  if (state is SaveRemoveWatchlistTVInitial) {
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        widget.isAddedWatchlist
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    );
                                  } else if (state is SaveRemoveWatchlistTVLoading) {
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        widget.isAddedWatchlist
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    );
                                  } else if (state is AddWatchlistTVSuccess) {
                                    widget.isAddedWatchlist = true;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(state.result)));
                                  } else if (state is DeleteWatchlistTVSuccess) {
                                    widget.isAddedWatchlist = false;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(state.result)));
                                  } else if (state is SaveRemoveWatchlistTVError) {
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
                                child: BlocBuilder<SaveRemoveWatchlistTVBloc, SaveRemoveWatchlistTVState>(
                                    bloc: _saveRemoveWatchlistTVBloc,
                                    builder: (context, state) {
                                      if (state is SaveRemoveWatchlistTVInitial) {
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
                                      if (state is SaveRemoveWatchlistTVLoading) {
                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            widget.isAddedWatchlist
                                                ? const Icon(Icons.check)
                                                : const Icon(Icons.add),
                                            const Text('Watchlist'),
                                          ],
                                        );
                                      } else if (state is AddWatchlistTVSuccess) {
                                        widget.isAddedWatchlist = true;
                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.check),
                                            Text('Watchlist'),
                                          ],
                                        );
                                      } else
                                      if (state is DeleteWatchlistTVSuccess) {
                                        widget.isAddedWatchlist = false;
                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.add),
                                            Text('Watchlist'),
                                          ],
                                        );
                                      } else
                                      if (state is SaveRemoveWatchlistTVError) {
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
                              _showGenres(widget.tv.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tv.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            Container(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final season = widget.tv.seasons[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => TVEpisodePage(
                                              idTV: widget.tv.id,
                                              seasonNumber: season.seasonNumber,
                                            ),),);
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: Column(
                                          children: [
                                            CachedNetworkImage(
                                              height: 140,
                                              imageUrl:
                                              'https://image.tmdb.org/t/p/w500${season.posterPath}',
                                              placeholder: (context, url) =>
                                                  Center(
                                                    child:
                                                    CircularProgressIndicator(),
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                  const Icon(Icons.error),
                                            ),
                                            Text(
                                              season.name,
                                            ),
                                            Text(
                                              '${season.episodeCount} episodes',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: widget.tv.seasons.length,
                              ),
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
                                  final tv = widget.recommendations[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          TVDetailPage.ROUTE_NAME,
                                          arguments: tv.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}