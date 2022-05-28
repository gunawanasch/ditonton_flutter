import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/now_playing_tv_bloc.dart';
import 'package:tv/presentation/provider/now_playing_tv_notifier.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/tv_injection.dart';

class NowPlayingTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tv';

  @override
  _NowPlayingTVPageState createState() => _NowPlayingTVPageState();
}

class _NowPlayingTVPageState extends State<NowPlayingTVPage> {
  final NowPlayingTVBloc _nowPlayingTVBloc = locator<NowPlayingTVBloc>();
  
  @override
  void initState() {
    _nowPlayingTVBloc.add(NowPlayingTV());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTVBloc, NowPlayingTVState>(
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
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TVCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is NowPlayingTVError) {
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