import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie_injection.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  final TopRatedMoviesBloc _topRatedMoviesBloc = locator<TopRatedMoviesBloc>();

  @override
  void initState() {
    _topRatedMoviesBloc.add(TopRatedMovies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
          bloc: _topRatedMoviesBloc,
          builder: (context, state) {
            if (state is TopRatedMoviesInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedMoviesSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                },
                itemCount: state.result.length,
              );
            } else if (state is TopRatedMoviesError) {
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
}
