import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/now_playing_tv_bloc.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tv/tv_injection.dart';

class HomeTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv';

  @override
  _HomeTVPageState createState() => _HomeTVPageState();
}

class _HomeTVPageState extends State<HomeTVPage> with RouteAware {
  final NowPlayingTVBloc _nowPlayingTVBloc = locator<NowPlayingTVBloc>();
  final PopularTVBloc _popularTVBloc = locator<PopularTVBloc>();
  final TopRatedTVBloc _topRatedTVBloc = locator<TopRatedTVBloc>();
  
  @override
  void initState() {
    _nowPlayingTVBloc.add(NowPlayingTV());
    _popularTVBloc.add(PopularTV());
    _topRatedTVBloc.add(TopRatedTV());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_TV_ROUTE);
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
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () =>
                    Navigator.pushNamed(context, NOW_PLAYING_TV_ROUTE),
              ),
              BlocBuilder<NowPlayingTVBloc, NowPlayingTVState>(
                  bloc: _nowPlayingTVBloc,
                  builder: (context, state) {
                    if (state is NowPlayingTVInitial) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is NowPlayingTVLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is NowPlayingTVSuccess) {
                      return TVList(state.result);
                    } else {
                      return const Text('Failed');
                    }
                  }
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, POPULAR_TV_ROUTE),
              ),
              BlocBuilder<PopularTVBloc, PopularTVState>(
                  bloc: _popularTVBloc,
                  builder: (context, state) {
                    if (state is PopularTVInitial) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is PopularTVLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is PopularTVSuccess) {
                      return TVList(state.result);
                    } else {
                      return const Text('Failed');
                    }
                  }
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TOP_RATED_TV_ROUTE),
              ),
              BlocBuilder<TopRatedTVBloc, TopRatedTVState>(
                  bloc: _topRatedTVBloc,
                  builder: (context, state) {
                    if (state is TopRatedTVInitial) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TopRatedTVLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TopRatedTVSuccess) {
                      return TVList(state.result);
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
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

class TVList extends StatelessWidget {
  final List<TV> tvList;

  TVList(this.tvList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TV_DETAIL_ROUTE,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvList.length,
      ),
    );
  }
}