import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_episode_bloc.dart';
import 'package:tv/presentation/widgets/tv_episode_card_list.dart';
import 'package:flutter/material.dart';
import 'package:tv/tv_injection.dart';

class TVEpisodePage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-episode';
  final int idTV;
  final int seasonNumber;

  TVEpisodePage({Key? key, required this.idTV, required this.seasonNumber})
      : super(key: key);

  @override
  _TVEpisodePageState createState() => _TVEpisodePageState(
      idTV: this.idTV, seasonNumber: this.seasonNumber);
}

class _TVEpisodePageState extends State<TVEpisodePage> {
  int idTV;
  int seasonNumber;
  final TVEpisodeBloc _tvEpisodeBloc = locator<TVEpisodeBloc>();

  _TVEpisodePageState({required this.idTV, required this.seasonNumber});

  @override
  void initState() {
    _tvEpisodeBloc.add(LoadTVEpisode(idTV: idTV, seasonNumber: seasonNumber));
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Episodes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TVEpisodeBloc, TVEpisodeState>(
            bloc: _tvEpisodeBloc,
            builder: (context, state) {
              if (state is TVEpisodeInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TVEpisodeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TVEpisodeSuccess) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tvEpisode = state.result[index];
                    return TVEpisodeCard(tvEpisode);
                  },
                  itemCount: state.result.length,
                );
              } else if (state is TVEpisodeError) {
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
