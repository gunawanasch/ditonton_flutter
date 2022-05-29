import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/movie.dart';
import 'package:movie/movie_injection.dart';
import 'package:flutter/material.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  final NowPlayingMoviesBloc _nowPlayingMoviesBloc = locator<NowPlayingMoviesBloc>();
  final PopularMoviesBloc _popularMoviesBloc = locator<PopularMoviesBloc>();
  final TopRatedMoviesBloc _topRatedMoviesBloc = locator<TopRatedMoviesBloc>();

  @override
  void initState() {
    _nowPlayingMoviesBloc.add(NowPlayingMovies());
    _popularMoviesBloc.add(PopularMovies());
    _topRatedMoviesBloc.add(TopRatedMovies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('TV'),
              onTap: () {
                Navigator.pushNamed(context, HOME_TV_ROUTE);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST_MOVIES_ROUTE);
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Watchlist TV'),
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST_TV_ROUTE);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ABOUT_ROUTE);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_ROUTE);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                bloc: _nowPlayingMoviesBloc,
                builder: (context, state) {
                  if (state is NowPlayingMoviesInitial) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingMoviesSuccess) {
                    return MovieList(state.result);
                  } else {
                    return const Text('Failed');
                  }
                }
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, POPULAR_MOVIES_ROUTE),
              ),
              BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
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
                      return MovieList(state.result);
                    } else {
                      return const Text('Failed');
                    }
                  }
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TOP_RATED_ROUTE),
              ),
              BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
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
                      return MovieList(state.result);
                    } else {
                      return const Text('Failed');
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MOVIE_DETAIL_ROUTE,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
