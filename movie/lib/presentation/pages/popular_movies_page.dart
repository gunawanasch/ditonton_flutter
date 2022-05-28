import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie_injection.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  final PopularMoviesBloc _popularMoviesBloc = locator<PopularMoviesBloc>();

  @override
  void initState() {
    _popularMoviesBloc.add(PopularMovies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          bloc: _popularMoviesBloc,
          builder: (context, state) {
            if (state is PopularMoviesInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMoviesSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                },
                itemCount: state.result.length,
              );
            } else if (state is PopularMoviesError) {
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
