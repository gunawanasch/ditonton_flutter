import 'package:core/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie_injection.dart';
import 'package:movie/presentation/bloc/get_watchlist_movies_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  final GetWatchlistMoviesBloc _getWatchlistMoviesBloc = locator<GetWatchlistMoviesBloc>();

  @override
  void initState() {
    _getWatchlistMoviesBloc.add(LoadWatchlistMovies());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetWatchlistMoviesBloc, GetWatchlistMoviesState>(
            bloc: _getWatchlistMoviesBloc,
            builder: (context, state) {
              if (state is GetWatchlistMoviesInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetWatchlistMoviesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetWatchlistMoviesSuccess) {
                if (state.result.isEmpty) {
                  return Center(
                    child: Text('Data is empty'),
                  );
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = state.result[index];
                      return MovieCard(movie);
                    },
                    itemCount: state.result.length,
                  );
                }
              } else if (state is GetWatchlistMoviesError) {
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
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
